//
//  VideoPlayView.m
//  02-测试VideoPlayerView
//
//  Created by 冯小宁 on 15/8/19.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "VideoPlayView.h"
@interface VideoPlayView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/** 播放器 */
@property (nonatomic, strong) AVPlayer *player;

/** playerLayer */
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

/** progressTimer */
@property (nonatomic, strong) NSTimer *progressTimer;

/** 是否显示toolView */
@property (nonatomic, assign, getter=isShowToolView) BOOL showToolView;

@end

@implementation VideoPlayView

+ (instancetype)videoPlayView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    // 从xib加载时进入此方法创建播放器和playerLayer
    self.player = [[AVPlayer alloc] init];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.imageView.layer addSublayer:self.playerLayer];
    
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    [self.progressSlider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];
    [self.progressSlider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
    
    [self removeProgressTimer];
    [self addProgressTimer];
    
    // 隐藏toolView
    self.toolView.alpha = 0;
    self.showToolView = NO;
    
    self.playOrPauseButton.selected = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 必须设置playerLayer的frame,视频没地播放
    self.playerLayer.frame = self.bounds;
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem
{
    _playerItem = playerItem;
    
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self addProgressTimer];
    [self.player play];
}

#pragma mark - 定时器操作
- (void)addProgressTimer
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

- (void)updateProgressInfo
{
    // 更新时间标签
    self.timeLabel.text = [self getTimeText];

    // 更新进度条信息
    self.progressSlider.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
}

- (NSString *)getTimeText
{
    NSInteger curMin =  (NSInteger)CMTimeGetSeconds(self.player.currentTime) / 60;
    NSInteger curSec =  (NSInteger)CMTimeGetSeconds(self.player.currentTime) % 60;
    
    NSInteger durMin = (NSInteger)CMTimeGetSeconds(self.player.currentItem.duration) / 60;
    NSInteger durSec = (NSInteger)CMTimeGetSeconds(self.player.currentItem.duration) % 60;
    
    NSString *progressString = [NSString stringWithFormat:@"%02ld:%02ld/", curMin,curSec];
    NSString *durationString = [NSString stringWithFormat:@"%02ld:%02ld", durMin, durSec];
    
    NSString *result = nil;
    if(durMin < 0 && durSec < 0) {
        result = @"00:00/00:00";
    } else {
        result = [progressString stringByAppendingString:durationString];
    }
    
    return result;
}

- (void)removeProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

#pragma mark - <VideoPlayViewDelegate>
- (IBAction)tapPlayingView:(UITapGestureRecognizer *)sender {
    self.showToolView = !self.showToolView;
    if(self.isShowToolView == NO) {
        self.toolView.alpha = 0;
        self.toolView.hidden = YES;
    } else {
        self.toolView.alpha = 1;
        self.toolView.hidden = NO;
    }
}

// 切换屏幕的方向
- (IBAction)switchOrientation:(UIButton *)sender {
    sender.selected = !sender.selected;
    if([self.delegate respondsToSelector:@selector(videoPlaySwitchOrientation:)]) {
        [self.delegate videoPlaySwitchOrientation:sender.selected];
    }
}

- (IBAction)playOrPause:(UIButton *)sender {
    sender.selected = !sender.selected;
    // 播放视频
    if(sender.selected) {
        [self addProgressTimer];
        
        [self.player play];
    } else {
        [self removeProgressTimer];
        
        [self.player pause];
    }
}

- (IBAction)startSlide:(UISlider *)sender {
    [self removeProgressTimer];
}

- (IBAction)valueChanged:(UISlider *)sender {
    self.timeLabel.text = [self getTimeText];
}

- (IBAction)endSlide:(UISlider *)sender {
    [self addProgressTimer];
    
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSlider.value;
    
    // 设置当前播放时间
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_MSEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
    [self.player play];
}

@end
