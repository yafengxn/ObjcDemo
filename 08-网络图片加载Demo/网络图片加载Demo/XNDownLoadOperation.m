//
//  XNDownLoadOperation.m
//  网络图片加载Demo
//
//  Created by 冯小宁 on 15/9/10.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "XNDownLoadOperation.h"
#import "NSString+XNDirectory.h"
@implementation XNDownLoadOperation
- (void)main
{
    @autoreleasepool {
        // 如果还没开始，直接取消
        if(self.isCancelled)  return;
        
        // 下载图片
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]];
        
        // 将下载的图片写入文件
        [data writeToFile:[NSString cacheDirectory:[self.urlString lastPathComponent]] atomically:YES];
        
        UIImage *image = [UIImage imageWithData:data];
        
        // 下载完成，还没设置到界面上，
        if(self.isCancelled)  return;
        
        // 判断completionBlock是否可用
        if(self.completion) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.completion(image);
            }];
        }
    }
}
@end
