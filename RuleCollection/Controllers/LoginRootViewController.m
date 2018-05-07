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

@interface LoginRootViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation LoginRootViewController
- (IBAction)login:(id)sender {
    
    [self.view endEditing:YES];
    
    UIView *uv = [[UIView alloc] init];
    uv.backgroundColor = [UIColor blackColor];
    uv.alpha = 0.7;
    uv.frame = self.view.bounds;
    [self.view addSubview:uv];
    
    [SVProgressHUD showWithStatus:@"正在登录..."];
    NSDictionary *params = @{ @"username":self.txtUserName.text, @"pwd":self.txtPassword.text };
    [Http requesetWithUrl:@"http://www.moxcomic.com:23333/Store/Login" params:params sucess:^(id responseObject) {
        Result *res = [Result yy_modelWithJSON:responseObject];
        if ([res.code isEqualToString:@"200"]) {
            //登录成功
            //[uv removeFromSuperview];
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *filePath = [docPath stringByAppendingPathComponent:@"UserConfig.plist"];
            NSDictionary *dict = @{ @"username":self.txtUserName.text, @"pwd":self.txtPassword.text };
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
    
    [self.txtUserName addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.txtPassword addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [self textChange];
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"UserConfig.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        if (!dict[@"username"] && !dict[@"password"]) {
            
            [self.btnLogin setTitle:@"正在登录..." forState:UIControlStateNormal];
            self.btnLogin.enabled = NO;
            
            self.txtUserName.text = dict[@"username"];
            self.txtPassword.text = dict[@"password"];
            
            [self performSelector:@selector(login:) withObject:nil afterDelay:1.5];
        }
    }
}

- (void)textChange {
    self.btnLogin.enabled = self.txtUserName.text.length > 0 && self.txtPassword.text.length > 0;
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
