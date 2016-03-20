//
//  NSTimer+Convience.h
//  Minions
//
//  Created by 冯小宁 on 16/3/20.
//  Copyright © 2016年 yafengxn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^XNCallBackBlock)();

@interface NSTimer (Convience)

+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeat callBackBlock:(XNCallBackBlock)callBackBlock;

+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval count:(NSInteger)count callBackBlock:(XNCallBackBlock)callBackBlock;
@end
