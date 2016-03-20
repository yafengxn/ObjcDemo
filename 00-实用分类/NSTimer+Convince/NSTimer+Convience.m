//
//  NSTimer+Convience.m
//  Minions
//
//  Created by 冯小宁 on 16/3/20.
//  Copyright © 2016年 yafengxn. All rights reserved.
//

#import "NSTimer+Convience.h"

@implementation NSTimer (Convience)

+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeat callBackBlock:(XNCallBackBlock)callBackBlock {
    return [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(updateTimer:) userInfo:[callBackBlock copy] repeats:repeat];
}

+ (void)updateTimer:(NSTimer *)timer {
    XNCallBackBlock block = timer.userInfo;
    if(block) {
        block();
    }
}


+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval count:(NSInteger)count callBackBlock:(XNCallBackBlock)callBackBlock {
    NSDictionary *userInfo = @{
                               @"count" : @(count),
                               @"callBackBlock" : [callBackBlock copy]
                           };
    return [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(updateTimer2:) userInfo:userInfo repeats:YES];
}

+ (void)updateTimer2:(NSTimer *)timer {
    static NSUInteger currCount = 0;
    
    NSDictionary *userInfo = timer.userInfo;
    NSInteger count = [userInfo[@"count"] integerValue];
    XNCallBackBlock block = userInfo[@"callBackBlock"];
 
    if(currCount < count) {
        currCount ++;
        
        if(block) {
            block();
        }
        
    } else {
        currCount = 0;
        [timer pauseTimer];
        [timer invalidate];
        timer = nil;
    }

}

- (void)fireTimer {
    [self setFireDate:[NSDate distantPast]];
}

- (void)pauseTimer {
    [self setFireDate:[NSDate distantFuture]];
}

@end
