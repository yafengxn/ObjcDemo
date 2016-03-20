//
//  ViewController.m
//  UIImageDemoTest
//
//  Created by 冯小宁 on 15/12/10.
//  Copyright © 2015年 yafengxn. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+XNExtension.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIImage *image = [UIImage imageWithColor:[UIColor redColor]];
    self.imageView.image = image;
}


@end
