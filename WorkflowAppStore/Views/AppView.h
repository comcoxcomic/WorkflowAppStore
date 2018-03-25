//
//  AppView.h
//  WorkflowAppStore
//
//  Created by 神崎H亚里亚 on 2018/3/20.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class App;
@interface AppView : UITableViewCell
@property (nonatomic,strong) App *model;

+ (instancetype) aboutView;
@end
