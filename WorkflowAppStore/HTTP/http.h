//
//  http.h
//  WorkflowAppStore
//
//  Created by 神崎H亚里亚 on 2018/3/25.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface http : NSObject
+ (void)requesetWithUrl:(NSString *)url params:(NSDictionary *)params sucess:(void (^)(id responseObject))sucess failure:(void (^)(id responseObject))failure;
@end
