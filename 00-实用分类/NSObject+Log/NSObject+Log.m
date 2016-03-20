//
//  NSObject+Log.m
//  NSLog输出中文
//
//  Created by 冯小宁 on 15/9/17.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "NSObject+Log.h"

@implementation NSArray (Log)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *description = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *string = [NSString stringWithFormat:@"\t%@\n", obj];
        [description appendString:string];
    }];
    
    [description appendString:@")\n"];
    
    return description;
}
@end

@implementation NSDictionary (Log)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *description = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *string = [NSString stringWithFormat:@"\t%@ : %@\n", key, obj];
        [description appendString:string];
    }];
    
    [description appendString:@"}\n"];
    
    return description;
}

@end
