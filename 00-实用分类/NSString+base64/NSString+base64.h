//
//  NSString+base64.h
//  base64Demo
//
//  Created by 冯小宁 on 15/9/18.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (base64)
/**
 *  给你一个需要加密的字符串，返回base64加密结果
 */
+ (NSString *)base64Encode:(NSString *)encryptionString NS_AVAILABLE(10_9, 7_0);

/**
 *  给你一个需要解密的字符串，返回base64解密结果
 */
+ (NSString *)base64Decode:(NSString *)decipherString NS_AVAILABLE(10_9, 7_0);
@end
