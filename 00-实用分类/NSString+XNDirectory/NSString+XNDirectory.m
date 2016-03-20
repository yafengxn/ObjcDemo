//
//  NSString+XNDirectory.m
//  09-沙盒路径
//
//  Created by 冯小宁 on 15/9/10.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "NSString+XNDirectory.h"

@implementation NSString (XNDirectory)
+ (NSString *)cacheDirectory:(NSString *)fileName
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [directory stringByAppendingPathComponent:[fileName lastPathComponent]];
}

+ (NSString *)documentDirectory:(NSString *)fileName
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return  [directory stringByAppendingPathComponent:[fileName lastPathComponent]];
}

+ (NSString *)tempDirectory:(NSString *)fileName
{
    NSString *directory = NSTemporaryDirectory();
    return [directory stringByAppendingPathComponent:[fileName lastPathComponent]];
}
@end
