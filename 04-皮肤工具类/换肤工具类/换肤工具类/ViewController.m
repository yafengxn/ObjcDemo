//
//  ViewController.m
//  换肤工具类
//
//  Created by 冯小宁 on 15/8/21.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "ViewController.h"
#import "XNSkinTool.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rectImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeImages];
}

- (IBAction)redClick:(id)sender {
    [XNSkinTool setSkinColor:@"red"];
    
    [self changeImages];
}

- (IBAction)greenClick:(id)sender {
    [XNSkinTool setSkinColor:@"green"];
    
    [self changeImages];
}

- (IBAction)blueClick:(id)sender {
    [XNSkinTool setSkinColor:@"blue"];
    [self changeImages];
}

- (IBAction)orangeClick:(id)sender {
    [XNSkinTool setSkinColor:@"orange"];
    [self changeImages];
}

- (void)changeImages
{
    self.faceImageView.image = [XNSkinTool skinToolWithImageName:@"face.png"];
    self.heartImageView.image = [XNSkinTool skinToolWithImageName:@"heart.png"];
    self.rectImageView.image = [XNSkinTool skinToolWithImageName:@"rect.png"];
}

@end
