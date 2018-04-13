//
//  AppFrame.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/4/13.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "AppFrame.h"
#import "App.h"
#import <CoreGraphics/CoreGraphics.h>

#define textFont [UIFont systemFontOfSize:12]

@implementation AppFrame
- (void)setApp:(Apps *)app {
    _app = app;
    
    CGFloat margin = 10;
    CGRect mainBound = [[UIScreen mainScreen] bounds];
    
    CGFloat iconW = 170;
    CGFloat iconH = 170;
    CGFloat iconY = margin;
    CGFloat iconX = (mainBound.size.width - iconW) / 2;
    _appIconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGSize appNameSize = [self sizeWithText:self.app.name maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:textFont];
    CGFloat appNameX = (mainBound.size.width - appNameSize.width) / 2;
    CGFloat appNameY = CGRectGetMaxY(_appIconFrame) + margin;
    _appNameFrame = CGRectMake(appNameX, appNameY, appNameSize.width, appNameSize.height);
    
    CGSize authorQQSize = [self sizeWithText:self.app.qq maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:textFont];
    CGFloat authorQQX = (mainBound.size.width - authorQQSize.width) / 2;
    CGFloat authorQQY = CGRectGetMaxY(_appNameFrame) + margin;
    _authorQQFrame = CGRectMake(authorQQX, authorQQY, authorQQSize.width, authorQQSize.height);
    
    CGSize appVersionSize = [self sizeWithText:self.app.ver maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:textFont];
    CGFloat appVersionX = (mainBound.size.width - appVersionSize.width) / 2;
    CGFloat appVersionY = CGRectGetMaxY(_authorQQFrame) + margin;
    _appVersionFrame = CGRectMake(appVersionX, appVersionY, appVersionSize.width, appVersionSize.height);
    
    CGSize appDescriptionSize = [self sizeWithText:self.app.des maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:textFont];
    CGFloat appDescriptionX = (mainBound.size.width - appDescriptionSize.width) / 2;
    CGFloat appDescriptionY = CGRectGetMaxY(_appVersionFrame) + margin;
    _appDescriptionFrame = CGRectMake(appDescriptionX, appDescriptionY, appDescriptionSize.width, appDescriptionSize.height);
    
    CGFloat btnShowInformationX = 0;
    CGFloat btnShowInformationY = CGRectGetMaxY(_appDescriptionFrame) + margin;
    CGFloat btnShowInformationW = mainBound.size.width / 2;
    CGFloat btnShowInformationH = 20;
    _btnShowInformationFrame = CGRectMake(btnShowInformationX, btnShowInformationY, btnShowInformationW, btnShowInformationH);
    
    CGFloat btnAddRuleX = CGRectGetMaxX(_btnShowInformationFrame);
    CGFloat btnAddRuleY = btnShowInformationY;
    CGFloat btnAddRuleW = btnShowInformationW;
    CGFloat btnAddRuleH = btnShowInformationH;
    _btnAddRuleFrame = CGRectMake(btnAddRuleX, btnAddRuleY, btnAddRuleW, btnAddRuleH);
    
    _rowHeight = CGRectGetMaxY(_btnAddRuleFrame) + margin;
}

- (CGSize) sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font {
    NSDictionary *attr = @{ NSFontAttributeName : font };
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}
@end
