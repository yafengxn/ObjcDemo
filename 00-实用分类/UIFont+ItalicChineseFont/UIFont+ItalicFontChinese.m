//
//  UIFont+ItalicFontChinese.m
//  Text
//
//  Created by 冯小宁 on 15/9/18.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "UIFont+ItalicFontChinese.h"

@implementation UIFont (ItalicFontChinese)

+ (instancetype)italicChineseFont:(UIFont *)font
{
    return [self italicChineseFont:font italicAngle:15];
}

+ (instancetype)italicChineseFont:(UIFont *)font italicAngle:(NSInteger)angle
{
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(angle * (CGFloat)M_PI / 180), 1, 0, 0);
    
    UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName :[ UIFont systemFontOfSize :17]. fontName matrix:matrix];
    
    return [UIFont fontWithDescriptor:desc size:17];
}
@end
