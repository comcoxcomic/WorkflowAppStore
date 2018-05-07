//
//  AppViewController.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/5/7.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "AppViewController.h"
#import "App.h"
#import <UIImageView+AFNetworking.h>

@interface AppViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *appVersion;
@property (weak, nonatomic) IBOutlet UILabel *appDescription;
@property (weak, nonatomic) IBOutlet UILabel *appAuthor;

@end

@implementation AppViewController
- (IBAction)exitApp:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setApp:(Apps *)App{
    _App = App;
    
    [self.appIcon setImageWithURL:[NSURL URLWithString:_App.AppPicUrl] placeholderImage:[UIImage imageNamed:@"AboutIcon"]];
    self.appName.text = _App.AppName;
    self.appAuthor.text = _App.AuthorName;
    self.appVersion.text = _App.AppVersion;
    self.appDescription.text = _App.AppDescription;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
