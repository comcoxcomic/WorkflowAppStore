//
//  AppFrame.h
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/4/13.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Apps;

@interface AppFrame : NSObject
@property (nonatomic, strong) Apps *app;
@property (nonatomic, assign) CGRect appIconFrame;
@property (nonatomic, assign) CGRect appNameFrame;
@property (nonatomic, assign) CGRect authorQQFrame;
@property (nonatomic, assign) CGRect appVersionFrame;
@property (nonatomic, assign) CGRect appDescriptionFrame;
@property (nonatomic, assign) CGRect btnShowInformationFrame;
@property (nonatomic, assign) CGRect btnAddRuleFrame;
@property (nonatomic, assign) CGFloat rowHeight;
@end
