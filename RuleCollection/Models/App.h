//
//  App.h
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/3/20.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Apps :NSObject
@property (nonatomic , copy) NSString              * AuthorQQ;
@property (nonatomic , copy) NSString              * AppPicUrl;
@property (nonatomic , assign) NSInteger             rowId;
@property (nonatomic , copy) NSString              * AppUpdateTime;
@property (nonatomic , copy) NSString              * AppVersion;
@property (nonatomic , assign) NSInteger             Download;
@property (nonatomic , copy) NSString              * AppUploadTime;
@property (nonatomic , copy) NSString              * AppDescription;
@property (nonatomic , copy) NSString              * AppName;
@property (nonatomic , copy) NSString              * AuthorName;

@end

@interface App :NSObject
@property (nonatomic , strong) NSArray<Apps *>              * apps;
@property (nonatomic , assign) NSInteger              code;

@end

