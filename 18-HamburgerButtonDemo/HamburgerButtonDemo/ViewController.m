//
//  ViewController.m
//  HamburgerButtonDemo
//
//  Created by yafengxn on 16/5/17.
//  Copyright © 2016年 yafengxn. All rights reserved.
//

#import "ViewController.h"
#import "YCHamburgerButton.h"

@interface ViewController ()

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
- (IBAction)buttonClick:(YCHamburgerButton *)sender
{
    if (sender.currentMode == YCHamburgerButtonModeHamburger) {
        [sender setCurrentModeWithAnimation:YCHamburgerButtonModeCross];
    } else {
        [sender setCurrentModeWithAnimation:YCHamburgerButtonModeHamburger];
    }
}

@end
