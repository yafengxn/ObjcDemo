//
//  ViewController.m
//  01-视频播放Demo
//
//  Created by 冯小宁 on 15/8/20.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "ViewController.h"
#import "VideoPlayView.h"

@interface ViewController ()<VideoPlayViewDelegate>
/** VideoPlayView */
@property (nonatomic, weak) VideoPlayView *playerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建添加VideoPlayView
    VideoPlayView *playerView = [VideoPlayView videoPlayView];
    playerView.delegate = self;
    playerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    [self.view addSubview:playerView];
    self.playerView = playerView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if([self.playerView pointInside:point withEvent:UIEventTypeTouches])
        return;
    
    NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/3e35cbb0-c8e5-4827-9614-b5a355259010/L.mp4"];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    [self.playerView setPlayerItem:item];
}

- (void)videoPlaySwitchOrientation:(BOOL)isFull
{
    // 调整playerView的frame
    if(isFull) {
        self.playerView.frame = self.view.bounds;
    } else {
        self.playerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    }
}

@end
