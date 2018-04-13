//
//  App.h
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/3/20.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Apps :NSObject
@property (nonatomic , copy) NSString              * qq;
@property (nonatomic , copy) NSString              * picURL;
@property (nonatomic , assign) NSInteger             rowId;
@property (nonatomic , copy) NSString              * updateTime;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * ver;
@property (nonatomic , assign) NSInteger             downloadCount;
@property (nonatomic , copy) NSString              * firstTime;
@property (nonatomic , copy) NSString              * des;
@property (nonatomic , copy) NSString              * free;
@property (nonatomic , copy) NSString              * name;

@end

@interface App :NSObject
@property (nonatomic , strong) NSArray<Apps *>              * apps;
@property (nonatomic , assign) NSInteger              code;

@end

