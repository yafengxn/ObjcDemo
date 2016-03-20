//
//  XNButton.m
//  freedomStudy
//
//  Created by 冯小宁 on 15/10/21.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "XNButton.h"

@implementation XNButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.imageView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.width;
    
    // 调整图片位置
    self.imageView.frame = frame;
    
    
    frame.origin.x = 0;
    frame.origin.y = self.imageView.frame.size.height;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height - self.imageView.frame.size.height;
    
    // 调整titleLabel的位置
    self.titleLabel.frame = frame;
}
@end
