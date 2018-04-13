//
//  Util.h
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/4/11.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Util : NSObject

+ (UIViewController *)getViewControllerWithView:(UIView *)view;
+ (NSString *)urlEncodeStr:(NSString *)input;

@end
