//
//  AboutView.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/4/13.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "AboutView.h"

#define textFont [UIFont systemFontOfSize:12]

@implementation AboutView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat margin = 10;
        CGRect mainBound = [[UIScreen mainScreen] bounds];
        
        UIImageView *imageIcon = [[UIImageView alloc] init];
        [imageIcon setImage:[UIImage imageNamed:@"NoImage"]];
        CGFloat iconW = 170;
        CGFloat iconH = 170;
        CGFloat iconX = (mainBound.size.width - iconW) / 2;
        CGFloat iconY = margin;
        imageIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
        [self addSubview:imageIcon];
        
        UILabel *lblAppName = [[UILabel alloc] init];
        lblAppName.text = @"规则仓库";
        lblAppName.font = textFont;
        lblAppName.numberOfLines = 0;
        CGSize appNameSize = [Util sizeWithText:lblAppName.text maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:textFont];
        CGFloat appNameX = (mainBound.size.width - appNameSize.width) / 2;
        CGFloat appNameY = CGRectGetMaxY(imageIcon.frame) + margin;
        lblAppName.frame = CGRectMake(appNameX, appNameY, appNameSize.width, appNameSize.height);
        [self addSubview:lblAppName];
        
        UILabel *lblAppVersion = [[UILabel alloc] init];
        lblAppVersion.text = @"版本：公测版本";
        lblAppVersion.font = textFont;
        lblAppVersion.numberOfLines = 0;
        CGSize appVersionSize = [Util sizeWithText:lblAppVersion.text maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:textFont];
        CGFloat appVersionX = (mainBound.size.width - appVersionSize.width) / 2;
        CGFloat appVersionY = CGRectGetMaxY(lblAppName.frame) + margin;
        lblAppVersion.frame = CGRectMake(appVersionX, appVersionY, appVersionSize.width, appVersionSize.height);
        [self addSubview:lblAppVersion];
        
        UILabel *lblAppAuthor = [[UILabel alloc] init];
        lblAppAuthor.text = @"开发者：神崎·H·亚里亚";
        lblAppAuthor.font = textFont;
        lblAppAuthor.numberOfLines = 0;
        CGSize appAuthorSize = [Util sizeWithText:lblAppAuthor.text maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:textFont];
        CGFloat appAuthorX = (mainBound.size.width - appAuthorSize.width) / 2;
        CGFloat appAuthorY = CGRectGetMaxY(lblAppVersion.frame) + margin;
        lblAppAuthor.frame = CGRectMake(appAuthorX, appAuthorY, appAuthorSize.width, appAuthorSize.height);
        [self addSubview:lblAppAuthor];
        
        UILabel *lblAppAbout = [[UILabel alloc] init];
        lblAppAbout.text = @"如何上传规则？\n1.加入官方群\n2.申请作者权限\n3.审核后开通权限";
        lblAppAbout.font = textFont;
        lblAppAbout.numberOfLines = 0;
        CGSize appAboutSize = [Util sizeWithText:lblAppAbout.text maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:textFont];
        CGFloat appAboutX = (mainBound.size.width - appAboutSize.width) / 2;
        CGFloat appAboutY = CGRectGetMaxY(lblAppAuthor.frame) + margin;
        lblAppAbout.frame = CGRectMake(appAboutX, appAboutY, appAboutSize.width, appAboutSize.height);
        [self addSubview:lblAppAbout];
        
        UIButton *btnContact = [[UIButton alloc] init];
        [btnContact setTitle:@"联系我们" forState:UIControlStateNormal];
        [btnContact setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnContact setTitleColor: [UIColor grayColor] forState:UIControlStateHighlighted];
        [btnContact.layer setBorderWidth:1.0];
        [btnContact.layer setCornerRadius:10.0];
        [btnContact.layer setMasksToBounds:YES];
        btnContact.layer.borderColor = [UIColor blueColor].CGColor;
        [btnContact addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
        CGFloat contactW = mainBound.size.width / 2;
        CGFloat contactH = 40;
        CGFloat contactX = 0;
        CGFloat contactY = CGRectGetMaxY(frame) - contactH - frame.origin.y;
        
        btnContact.frame = CGRectMake(contactX, contactY, contactW, contactH);
        [self addSubview:btnContact];
        
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
        CGFloat joinQQGroupX = CGRectGetMaxX(btnContact.frame);
        CGFloat joinQQGroupY = contactY;
        btnJoinQQGroup.frame = CGRectMake(joinQQGroupX, joinQQGroupY, joinQQGroupW, joinQQGroupH);
        [self addSubview:btnJoinQQGroup];
    }
    return self;
}

- (void)joinQQGroup {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://jq.qq.com/?_wv=1027&k=551cmsq"]];
}

- (void)contact {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto:moxcomic@gmail.com"]];
}

@end
