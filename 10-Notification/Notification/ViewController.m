//
//  ViewController.m
//  Notification
//
//  Created by 冯小宁 on 15/9/10.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
/**
  要求，程序退到后台，一旦“进入前台”，如果当前控制器是活动控制器，需要 做一次刷新操作
 
  解决办法：在控制器中添加监听应用程序激活通知的监听器，这样当应用程序从后台回到前台时就会
        调用backToLive方法
 
  注意：如果其他控制器也监听了同样的消息，但是要求是只有当前激活控制器响应，我们应该将添加通知、移除通知写在viewDidAppear\viewDidDisappear中
 */


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToLive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)backToLive
{
    NSLog(@"当前控制器的视图被激活，可以进行刷新操作");
}

@end
