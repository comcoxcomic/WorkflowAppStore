//
//  AboutViewController.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/4/16.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "AboutViewController.h"
#define textFont [UIFont systemFontOfSize:12]

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [self initAboutView];
}

- (void) initAboutView {
    CGFloat margin = 10;
    CGRect mainBound = [[UIScreen mainScreen] bounds];
    
    UIImageView *imageIcon = [[UIImageView alloc] init];
    [imageIcon setImage:[UIImage imageNamed:@"AboutIcon"]];
    CGFloat iconW = 170;
    CGFloat iconH = 170;
    CGFloat iconX = (mainBound.size.width - iconW) / 2;
    CGFloat iconY = CGRectGetMaxY(self.navigationController.navigationBar.frame) + margin;
    imageIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    [self.view addSubview:imageIcon];
    
    UILabel *lblAppName = [[UILabel alloc] init];
    lblAppName.text = @"规则仓库";
    lblAppName.font = textFont;
    lblAppName.numberOfLines = 0;
    CGSize appNameSize = [Util sizeWithText:lblAppName.text maxSize:CGSizeMake(mainBound.size.width - margin * 2, MAXFLOAT) font:textFont];
    CGFloat appNameX = (mainBound.size.width - appNameSize.width) / 2;
    CGFloat appNameY = CGRectGetMaxY(imageIcon.frame) + margin;
    lblAppName.frame = CGRectMake(appNameX, appNameY, appNameSize.width, appNameSize.height);
    [self.view addSubview:lblAppName];
    
    UILabel *lblAppVersion = [[UILabel alloc] init];
    lblAppVersion.text = @"版本：公测版本";
    lblAppVersion.font = textFont;
    lblAppVersion.numberOfLines = 0;
    CGSize appVersionSize = [Util sizeWithText:lblAppVersion.text maxSize:CGSizeMake(mainBound.size.width - margin * 2, MAXFLOAT) font:textFont];
    CGFloat appVersionX = (mainBound.size.width - appVersionSize.width) / 2;
    CGFloat appVersionY = CGRectGetMaxY(lblAppName.frame) + margin;
    lblAppVersion.frame = CGRectMake(appVersionX, appVersionY, appVersionSize.width, appVersionSize.height);
    [self.view addSubview:lblAppVersion];
    
    UILabel *lblAppAuthor = [[UILabel alloc] init];
    lblAppAuthor.text = @"开发者：神崎·H·亚里亚";
    lblAppAuthor.font = textFont;
    lblAppAuthor.numberOfLines = 0;
    CGSize appAuthorSize = [Util sizeWithText:lblAppAuthor.text maxSize:CGSizeMake(mainBound.size.width - margin * 2, MAXFLOAT) font:textFont];
    CGFloat appAuthorX = (mainBound.size.width - appAuthorSize.width) / 2;
    CGFloat appAuthorY = CGRectGetMaxY(lblAppVersion.frame) + margin;
    lblAppAuthor.frame = CGRectMake(appAuthorX, appAuthorY, appAuthorSize.width, appAuthorSize.height);
    [self.view addSubview:lblAppAuthor];
    
    UILabel *lblAppAbout = [[UILabel alloc] init];
    lblAppAbout.text = @"如何上传规则？\n1.加入官方QQ群\n2.准备1～3份自己开发的规则\n3.发送到邮箱moxcomic@gmail.com进行审核\n4.审核通过后邮件通知具体流程";
    lblAppAbout.font = textFont;
    lblAppAbout.textColor = [UIColor blueColor];
    lblAppAbout.numberOfLines = 0;
    CGSize appAboutSize = [Util sizeWithText:lblAppAbout.text maxSize:CGSizeMake(mainBound.size.width - margin * 2, MAXFLOAT) font:textFont];
    CGFloat appAboutX = (mainBound.size.width - appAboutSize.width) / 2;
    CGFloat appAboutY = CGRectGetMaxY(lblAppAuthor.frame) + margin;
    lblAppAbout.frame = CGRectMake(appAboutX, appAboutY, appAboutSize.width, appAboutSize.height);
    [self.view addSubview:lblAppAbout];
    
    UIButton *btnContact = [[UIButton alloc] init];
    [btnContact setTitle:@"联系我们" forState:UIControlStateNormal];
    [btnContact setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnContact setTitleColor: [UIColor grayColor] forState:UIControlStateHighlighted];
    [btnContact.layer setBorderWidth:1.0];
    [btnContact.layer setCornerRadius:10.0];
    [btnContact.layer setMasksToBounds:YES];
    btnContact.layer.borderColor = [UIColor blueColor].CGColor;
    [btnContact addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
    CGFloat contactW = mainBound.size.width / 2 - 1;
    CGFloat contactH = 40;
    CGFloat contactX = 0;
    CGFloat contactY = CGRectGetMaxY(self.view.frame) - contactH - self.view.frame.origin.y;
    
    btnContact.frame = CGRectMake(contactX, contactY, contactW, contactH);
    [self.view addSubview:btnContact];
    
    UIButton *btnJoinQQGroup = [[UIButton alloc] init];
    [btnJoinQQGroup setTitle:@"加入QQ群" forState:UIControlStateNormal];
    [btnJoinQQGroup setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnJoinQQGroup setTitleColor: [UIColor grayColor] forState:UIControlStateHighlighted];
    [btnJoinQQGroup.layer setBorderWidth:1.0];
    [btnJoinQQGroup.layer setCornerRadius:10.0];
    [btnJoinQQGroup.layer setMasksToBounds:YES];
    btnJoinQQGroup.layer.borderColor = [UIColor blueColor].CGColor;
    [btnJoinQQGroup addTarget:self action:@selector(joinQQGroup) forControlEvents:UIControlEventTouchUpInside];
    CGFloat joinQQGroupW = contactW;
    CGFloat joinQQGroupH = contactH;
    CGFloat joinQQGroupX = CGRectGetMaxX(btnContact.frame) + 1;
    CGFloat joinQQGroupY = contactY;
    btnJoinQQGroup.frame = CGRectMake(joinQQGroupX, joinQQGroupY, joinQQGroupW, joinQQGroupH);
    [self.view addSubview:btnJoinQQGroup];
    
    UILabel *copyright = [[UILabel alloc] init];
    copyright.text = @"©2018 幻梦次元";
    copyright.numberOfLines = 0;
    copyright.font = textFont;
    CGSize copyrightSize = [Util sizeWithText:copyright.text maxSize:CGSizeMake(mainBound.size.width, MAXFLOAT) font:textFont];
    CGFloat copyrightX = (mainBound.size.width - copyrightSize.width) / 2;
    CGFloat copyrightY = btnJoinQQGroup.frame.origin.y - copyrightSize.height;
    copyright.frame = CGRectMake(copyrightX, copyrightY, copyrightSize.width, copyrightSize.height);
    [self.view addSubview:copyright];
    
    UILabel *serviceEndTime = [[UILabel alloc] init];
    serviceEndTime.text = @"Support Time:2019-03-21";
    serviceEndTime.numberOfLines = 0;
    serviceEndTime.font = textFont;
    CGSize serviceEndTimeSize = [Util sizeWithText:serviceEndTime.text maxSize:CGSizeMake(mainBound.size.width, MAXFLOAT) font:textFont];
    CGFloat serviceEndTimeX = (mainBound.size.width - serviceEndTimeSize.width) / 2;
    CGFloat serviceEndTimeY = copyrightY - serviceEndTimeSize.height;
    serviceEndTime.frame = CGRectMake(serviceEndTimeX, serviceEndTimeY, serviceEndTimeSize.width, serviceEndTimeSize.height);
    [self.view addSubview:serviceEndTime];
}

- (void)joinQQGroup {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://jq.qq.com/?_wv=1027&k=551cmsq"]];
}

- (void)contact {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto:moxcomic@gmail.com"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
