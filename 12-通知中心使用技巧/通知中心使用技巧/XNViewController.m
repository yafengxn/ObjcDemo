//
//  XNViewController.m
//  通知中心使用技巧
//
//  Created by 冯小宁 on 15/9/11.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "XNViewController.h"

@implementation XNViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChange
{
    NSLog(@"XNViewController --- textChange");
}
@end
