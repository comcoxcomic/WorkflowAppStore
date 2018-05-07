//
//  Result.h
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/5/8.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * result;
@property (nonatomic , copy) NSString              * err_msg;
@property (nonatomic , copy) NSString              * msg;
@end
