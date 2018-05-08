//
//  RegisterViewController.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/5/7.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "RegisterViewController.h"
#import <SVProgressHUD.h>
#import "Result.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirm;
@property (weak, nonatomic) IBOutlet UITextField *txtQQ;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

@end

@implementation RegisterViewController
- (IBAction)register:(id)sender {
    self.btnRegister.enabled = NO;
    if (![self.txtUserName.text isNullOrWhiteSpace] && ![self.txtPassword.text isNullOrWhiteSpace] && ![self.txtConfirm.text isNullOrWhiteSpace] && ![self.txtQQ.text isNullOrWhiteSpace] && ![self.txtEmail.text isNullOrWhiteSpace]) {
        if (![self.txtPassword.text isEqualToString:self.txtConfirm.text]) {
            [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
            self.btnRegister.enabled = YES;
        } else {
            NSDictionary *params = @{
                                   @"username":self.txtUserName.text,
                                   @"md5_1":[self.txtPassword.text md5Encode],
                                   @"qq":self.txtQQ.text,
                                   @"mail":self.txtEmail.text
                                   };
            NSLog(@"%@", params);
            [Http requesetWithUrl:@"http://www.moxcomic.com:23333/Store/Register" params:params sucess:^(id responseObject) {
                Result *res = [Result yy_modelWithJSON:responseObject];
                NSLog(@"%@", responseObject);
                
                if ([res.code isEqualToString:@"200"]) {
                    //注册成功
                    [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                    [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
                    [self performSelector:@selector(dissmissWithSuccess) withObject:nil afterDelay:1.5];
                } else {
                    [SVProgressHUD showErrorWithStatus:res.msg];
                    [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
                }
            } failure:^(id responseObject) {
                
            }];
        }
    } else {
        [SVProgressHUD showErrorWithStatus:@"请正确填写注册信息"];
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
        self.btnRegister.enabled = YES;
    }
}

- (void)dissmissWithSuccess {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.Success) {
            self.Success(YES, self.txtUserName.text, self.txtPassword.text);
        }
    }];
}

- (IBAction)exitRegister:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.Success) {
            self.Success(NO, nil, nil);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
