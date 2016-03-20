//
//  UIFont+ItalicFontChinese.h
//  Text
//
//  Created by 冯小宁 on 15/9/18.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//
//  提供返回倾斜的中文字体!!!

#import <UIKit/UIKit.h>

@interface UIFont (ItalicFontChinese)
+ (instancetype)italicChineseFont:(UIFont *)font;
+ (instancetype)italicChineseFont:(UIFont *)font italicAngle:(NSInteger)angle;
@end
