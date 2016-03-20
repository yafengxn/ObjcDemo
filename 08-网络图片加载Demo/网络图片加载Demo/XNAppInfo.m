//
//  XNAppInfo.m
//  网络图片加载Demo
//
//  Created by 冯小宁 on 15/9/9.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "XNAppInfo.h"

@implementation XNAppInfo

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)appInfoWithDict:(NSDictionary *)dict
{
    return  [[self alloc] initWithDict:dict];
}

@end
