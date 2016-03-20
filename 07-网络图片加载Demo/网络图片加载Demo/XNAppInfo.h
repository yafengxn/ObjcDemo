//
//  XNAppInfo.h
//  网络图片加载Demo
//
//  Created by 冯小宁 on 15/9/9.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XNAppInfo : NSObject
/** name */
@property (nonatomic, copy) NSString *name;
/** icon */
@property (nonatomic, copy) NSString *icon;
/** download */
@property (nonatomic, copy) NSString *download;

+ (instancetype)appInfoWithDict:(NSDictionary *)dict;

@end
