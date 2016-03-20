//
//  VideoPlayView.h
//  02-测试VideoPlayerView
//
//  Created by 冯小宁 on 15/8/19.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol VideoPlayViewDelegate <NSObject>

@optional
- (void)videoPlaySwitchOrientation:(BOOL)isFull;

@end

@interface VideoPlayView : UIView

+ (instancetype)videoPlayView;

/** 代理 */
@property (nonatomic, weak) id<VideoPlayViewDelegate> delegate;

/** playItem */
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end
