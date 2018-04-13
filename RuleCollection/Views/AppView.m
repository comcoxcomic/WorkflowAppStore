//
//  AppView.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/3/20.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "AppView.h"
#import "App.h"
@interface AppView()
- (IBAction)btnJoinGroup:(id)sender;
- (IBAction)btnEmail:(id)sender;

@end

@implementation AppView

+ (instancetype)aboutView
{
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    return [[rootBundle loadNibNamed:@"AppView" owner:nil options:nil] firstObject];
}
- (IBAction)btnJoinGroup:(id)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://jq.qq.com/?_wv=1027&k=551cmsq"]];
}

- (IBAction)btnEmail:(id)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto:moxcomic@gmail.com"]];
}
@end
