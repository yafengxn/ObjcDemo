//
//  XNSkinTool.m
//  换肤工具类
//
//  Created by 冯小宁 on 15/8/21.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "XNSkinTool.h"

static NSString *_skinColor = @"red";

@implementation XNSkinTool

+ (void)initialize
{
    // 读取文件中保存的皮肤颜色
    NSString *skinColor = [[NSUserDefaults standardUserDefaults] objectForKey:@"skinColor"];
    
    if(_skinColor == nil) {
        _skinColor = skinColor;
    }
}

+ (void)setSkinColor:(NSString *)skinColor
{
    _skinColor = skinColor;
    
    // 保存当前皮肤颜色
    [[NSUserDefaults standardUserDefaults] setObject:skinColor forKey:@"skinColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UIImage *)skinToolWithImageName:(NSString *)name
{
    NSString *path = [NSString stringWithFormat:@"skin/%@/%@", _skinColor, name];
    return [UIImage imageNamed:path];
}

+ (UIColor *)skinToolWithLabelColor
{
    // 1.获取plistName的路径
    NSString *plistName = [NSString stringWithFormat:@"skin/%@/bgColor.plist", _skinColor];
    
    // 2.文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    
    // 3.读取颜色
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *labelColor = dict[@"labelBgColor"];
    
    // 4.将rgb解析出来
    NSArray *rgbArray = [labelColor componentsSeparatedByString:@","];
    NSInteger r = [rgbArray[0] integerValue];
    NSInteger g = [rgbArray[1] integerValue];
    NSInteger b = [rgbArray[2] integerValue];
    
    // 5.返回颜色
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

@end
