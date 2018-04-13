//
//  http.m
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/3/25.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import "Http.h"
#import <AFNetworking.h>

@implementation Http

//添加此单例方法是为了防止内存泄漏
+ (AFHTTPSessionManager *)sharedHTTPSession{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 30;
        //让AFN不要自动解析数据
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return manager;
}

+ (void)requesetWithUrl:(NSString *)url params:(NSDictionary *)params sucess:(void (^)(id responseObject))sucess failure:(void (^)(id responseObject))failure {
    AFHTTPSessionManager *manager = [Http sharedHTTPSession];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *dataStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSError *serializationError;
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializationError];
        if (serializationError) {
            NSLog(@"RequestApi error--- Json serialization error!");
            return;
        }
        sucess(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error.localizedDescription);
    }];
}


@end
