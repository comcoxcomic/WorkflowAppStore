//
//  Util.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/4/11.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (UIViewController *)getViewControllerWithView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font {
    NSDictionary *attr = @{ NSFontAttributeName : font };
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

+ (UIColor *)colorWithHexString:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)randomColor{
    NSMutableArray *colorArr = [[NSMutableArray alloc] init];
    
    //[colorArr addObject:[UIColor redColor]];
    [colorArr addObject:[UIColor orangeColor]];
    [colorArr addObject:[UIColor yellowColor]];
    [colorArr addObject:[UIColor greenColor]];
    [colorArr addObject:[UIColor cyanColor]];
    //[colorArr addObject:[UIColor blueColor]];
    //[colorArr addObject:[UIColor purpleColor]];
    //镉黄
    [colorArr addObject:[self colorWithHexString:@"#FF9912"]];
    //天蓝
    [colorArr addObject:[self colorWithHexString:@"#87CEEB"]];
    //薄荷色
    [colorArr addObject:[self colorWithHexString:@"#BDFCC9"]];
    //嫩绿色
    [colorArr addObject:[self colorWithHexString:@"#00FF7F"]];
    
    UIColor * randomColor= colorArr[arc4random_uniform((u_int32_t)colorArr.count)];
    
    return randomColor;
}

@end
