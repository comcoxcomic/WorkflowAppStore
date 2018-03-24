//
//  App.h
//  WorkflowAppStore
//
//  Created by 神崎H亚里亚 on 2018/3/20.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface App : NSObject
@property (nonatomic,assign) int Id;
@property (nonatomic,copy) NSString *Name;
@property (nonatomic,assign) BOOL New;
@property (nonatomic,copy) NSString *Free;
@property (nonatomic,copy) NSString *pInformation;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,copy) NSString *Author;
@property (nonatomic,copy) NSString *Version;
@property (nonatomic,copy) NSString *FirstReleaseTime;
@property (nonatomic,copy) NSString *UpdateDescription;
@property (nonatomic,copy) NSString *LastUpdateTime;
@property (nonatomic,copy) NSString *Pic;
@property (nonatomic,assign) int Download;
@property (nonatomic,copy) NSString *Note;

-(App *) initWithDictionary:(NSDictionary *)dict;
+(App *) appWithDictionary:(NSDictionary *)dict;
@end
