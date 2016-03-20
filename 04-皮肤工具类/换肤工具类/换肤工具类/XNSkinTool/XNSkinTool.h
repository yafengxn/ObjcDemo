//
//  XNSkinTool.h
//  换肤工具类
//
//  Created by 冯小宁 on 15/8/21.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XNSkinTool : NSObject

+ (void)setSkinColor:(NSString *)skinColor;
+ (UIImage *)skinToolWithImageName:(NSString *)name;
+ (UIColor *)skinToolWithLabelColor;

@end
