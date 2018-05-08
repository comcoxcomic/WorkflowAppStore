//
//  LoginRootViewController.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/5/7.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "LoginRootViewController.h"
#import <SVProgressHUD.h>
#import "Result.h"
#import "RegisterViewController.h"

@interface LoginRootViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

//密码是否为手动输入
@property (nonatomic, assign) BOOL isInput;

@end

@implementation LoginRootViewController
- (IBAction)register:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    RegisterViewController *lvc = (RegisterViewController *)[sb instantiateViewControllerWithIdentifier:@"RegisterVCId"];
    lvc.Success = ^(BOOL isSuccess, NSString *userName, NSString *password) {
        if (isSuccess) {
            //注册成功
            self.txtUserName.text = userName;
            self.txtPassword.text = password;
            self.isInput = YES;
            [self login:nil];
        }
    };
    lvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:lvc animated:YES completion:^{
        
    }];
}

- (IBAction)login:(id)sender {
    
    [self.view endEditing:YES];
    
    UIView *uv = [[UIView alloc] init];
    uv.backgroundColor = [UIColor blackColor];
    uv.alpha = 0.7;
    uv.frame = self.view.bounds;
    [self.view addSubview:uv];
    
    [SVProgressHUD showWithStatus:@"正在登录..."];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   [self.txtUserName.text urlEncode], @"username",
                                   self.txtPassword.text, @"pwd"
                                   , nil];
    if (!self.isInput) {
        [params addEntriesFromDictionary:@{ @"md5_1":self.txtPassword.text }];
    }
    NSLog(@"pp---%@", params);
    /*
     账号：Aria
     密码：19970220a
     问题详情：手动输入登录正常，自动登录密码错误
     过程：手动登录 -> 保存密码 -> 下次启动打开页面 -> 正常登录
     BUG：                  -> 密码错误
     */
    [Http requesetWithUrl:@"http://www.moxcomic.com:23333/Store/Login" params:params sucess:^(id responseObject) {
        Result *res = [Result yy_modelWithJSON:responseObject];
        if ([res.code isEqualToString:@"200"]) {
            //登录成功
            //[uv removeFromSuperview];
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *filePath = [docPath stringByAppendingPathComponent:@"UserConfig.plist"];
            NSDictionary *dict = @{ @"username":[self.txtUserName.text base64Encode], @"pwd":[self.txtPassword.text md5Encode] };
            [dict writeToFile:filePath atomically:YES];
            [self performSelector:@selector(dissmissWithSuccess:) withObject:@"YES" afterDelay:1.5];
        }
        else {
            [SVProgressHUD showErrorWithStatus:res.msg];
            //[uv removeFromSuperview];
            [uv performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:5];
        }
        
    } failure:^(id responseObject) {
        //[SVProgressHUD showErrorWithStatus:responseObject];
    }];
    [self.btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    self.btnLogin.enabled = YES;
}

- (void)dissmissWithSuccess:(NSObject *)success {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.Success){
            self.Success((BOOL)success, self.txtUserName.text);
        }
    }];
}

- (IBAction)exitLogin:(id)sender {
    [self dissmissWithSuccess:@"NO"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnLogin.enabled = NO;
    
    [self.txtUserName addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.txtPassword addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"UserConfig.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        if (![dict[@"username"] isNullOrWhiteSpace] && ![dict[@"password"] isNullOrWhiteSpace]) {
            [self.btnLogin setTitle:@"正在登录..." forState:UIControlStateNormal];
            self.btnLogin.enabled = NO;
            
            self.txtUserName.text = [dict[@"username"] base64Decode];
            self.txtPassword.text = dict[@"pwd"];
            self.isInput = NO;
            
            [self performSelector:@selector(login:) withObject:nil afterDelay:1.5];
        }
    }
}

- (void)textChange {
    self.btnLogin.enabled = self.txtUserName.text.length > 0 && self.txtPassword.text.length > 0;
    self.isInput = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
