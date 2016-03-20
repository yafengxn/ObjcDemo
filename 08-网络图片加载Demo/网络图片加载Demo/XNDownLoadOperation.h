//
//  XNDownLoadOperation.h
//  网络图片加载Demo
//
//  Created by 冯小宁 on 15/9/10.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XNDownLoadOperation : NSOperation

/** app.icon */
@property (nonatomic, copy) NSString *urlString;

/** completionBlock */
@property (nonatomic, copy) void(^completion)(UIImage *image);

@end
