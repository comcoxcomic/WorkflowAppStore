//
//  NSString+Extension.h
//  RuleCollection
//
//  Created by 神崎H亚里亚 on 2018/5/8.
//  Copyright © 2018年 moxcomic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (BOOL) isNullOrWhiteSpace;

- (NSString *)urlEncode;
- (NSString *)md5Encode;
- (NSString *)sha1Encode;
- (NSString *)base64Encode;
- (NSString *)base64Decode;
@end
