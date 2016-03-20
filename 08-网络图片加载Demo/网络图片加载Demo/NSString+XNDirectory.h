//
//  NSString+XNDirectory.h
//  09-沙盒路径
//
//  Created by 冯小宁 on 15/9/10.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XNDirectory)

/**
 *  获取指定文件的cache缓存路径
 *
 *  @param fileName 文件名
 *
 */
+ (NSString *)cacheDirectory:(NSString *)fileName;

/**
 *  获取指定文件的document缓存文件路径
 *
 *  @param fileName 文件名
 *
 */
+ (NSString *)documentDirectory:(NSString *)fileName;

/**
 *  获取制定文件的temp缓存文件路径
 *
 *  @param fileName 文件名
 *
 */
+ (NSString *)tempDirectory:(NSString *)fileName;
@end
