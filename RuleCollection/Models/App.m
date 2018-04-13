//
//  App.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/3/20.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "App.h"

@implementation App
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"apps" : [Apps class]};
}


@end


@implementation Apps
+ (NSDictionary *)modelCustomPropertyMapper {
    return@{@"rowId":@"Id",
            @"des":@"description"
            };
}
@end
