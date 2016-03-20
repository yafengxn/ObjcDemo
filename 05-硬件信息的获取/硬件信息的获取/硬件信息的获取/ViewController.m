//
//  ViewController.m
//  硬件信息的获取
//
//  Created by 冯小宁 on 15/8/22.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "ViewController.h"
#import "UIDevice+Hardware.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // 1.获取手机型号
    NSLog(@"手机型号:%@", [[UIDevice currentDevice] platformString]);
    
    // 2.获取剩余空间和一共多少空间
    NSLog(@"剩余空间:%@---总空间:%@", [[UIDevice currentDevice] freeDiskSpace], [[UIDevice currentDevice] totalDiskSpace]);
}


@end
