//
//  AppView.m
//  WorkflowAppStore
//
//  Created by 神崎H亚里亚 on 2018/3/20.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "AppView.h"
#import "App.h"
@interface AppView()
@property (weak, nonatomic) IBOutlet UIButton *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;
@property (weak, nonatomic) IBOutlet UILabel *lblDownload;
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;
@end

@implementation AppView

+ (instancetype)appView
{
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    return [[rootBundle loadNibNamed:@"AppView" owner:nil options:nil] lastObject];
}

+ (instancetype)aboutView
{
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    return [rootBundle loadNibNamed:@"AppView" owner:nil options:nil][1];
}
@end
