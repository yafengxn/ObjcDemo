//
//  XNOtherViewController.m
//  换肤工具类
//
//  Created by 冯小宁 on 15/8/22.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "XNOtherViewController.h"

/**
 * 可以将"XNSkinTool.h"包含在pch中,这样就不用每个控制器都包含"XNSkinTool.h"头文件了
 */
#import "XNSkinTool.h"

@interface XNOtherViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rectImageView;
@property (weak, nonatomic) IBOutlet UILabel *skinLabel;

@end

@implementation XNOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 * 将换肤操作放在viewDidAppear方法中,这样每次进入这个界面时候就会重新加载背景颜色
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.faceImageView.image = [XNSkinTool skinToolWithImageName:@"face.png"];
    self.heartImageView.image = [XNSkinTool skinToolWithImageName:@"heart.png"];
    self.rectImageView.image = [XNSkinTool skinToolWithImageName:@"rect.png"];
    
    // 设置label的北京颜色
    self.skinLabel.backgroundColor = [XNSkinTool skinToolWithLabelColor];
}

@end
