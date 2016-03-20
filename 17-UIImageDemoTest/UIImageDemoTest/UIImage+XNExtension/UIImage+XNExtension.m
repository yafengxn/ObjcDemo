//
//  UIImage+XNExtension.m
//  UIImageDemoTest
//
//  Created by 冯小宁 on 15/12/10.
//  Copyright © 2015年 yafengxn. All rights reserved.
//

#import "UIImage+XNExtension.h"

@implementation UIImage (XNExtension)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 填充颜色
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
