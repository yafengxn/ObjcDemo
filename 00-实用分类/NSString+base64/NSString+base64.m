//
//  NSString+base64.m
//  base64Demo
//
//  Created by 冯小宁 on 15/9/18.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "NSString+base64.h"

@implementation NSString (base64)
/**
 给定一个字符串，进行 base64 编码，返回结果
 
 终端测试命令
 $ echo -n A | base64
 */
+ (NSString *)base64Encode:(NSString *)encryptionString
{
    // 1.将字符串转换成二进制数据
    NSData *data = [encryptionString dataUsingEncoding:NSUTF8StringEncoding];
    // 2.返回base64编码后的结果
    return [data base64EncodedStringWithOptions:0];
}

/**
 终端测试命令
 
 $ echo -n QQ== | base64 -D
 */
+ (NSString *)base64Decode:(NSString *)decipherString
{
    // 1.将需要解密的字符串转化为二进制数据
    NSData *data = [[NSData alloc] initWithBase64EncodedString:decipherString options:0];
    // 2.返回解密好的字符串
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end
