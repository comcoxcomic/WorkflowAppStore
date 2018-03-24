//
//  App.m
//  WorkflowAppStore
//
//  Created by 神崎H亚里亚 on 2018/3/20.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "App.h"

@implementation App
- (App *)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.Id = [dict[@"Id"] intValue];
        self.Name = dict[@"Name"];
        self.New = [dict[@"New"] boolValue];
        self.Free = dict[@"Free"];
        self.pInformation = dict[@"pInformation"];
        self.Description = dict[@"Description"];
        self.Author = dict[@"Author"];
        self.Version = dict[@"Version"];
        self.FirstReleaseTime = dict[@"FirstReleaseTime"];
        self.UpdateDescription = dict[@"UpdateDescription"];
        self.LastUpdateTime = dict[@"LastUpdateTime"];
        self.Pic = dict[@"Pic"];
        self.Download = [dict[@"Download"] intValue];
        self.Note = dict[@"Note"];
    }
    return self;
}

+ (App *)appWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
@end
