//
//  YCHamburgerButton.h
//  HamburgerButtonDemo
//
//  Created by yafengxn on 16/5/17.
//  Copyright © 2016年 yafengxn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YCHamburgerButtonMode) {
    YCHamburgerButtonModeHamburger,
    YCHamburgerButtonModeCross
};

@interface YCHamburgerButton : UIButton
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat animationDurtion;
@property (nonatomic, assign) YCHamburgerButtonMode currentMode;

- (void)setCurrentModeWithAnimation:(YCHamburgerButtonMode)currentMode;
- (void)setCurrentModeWithAnimation:(YCHamburgerButtonMode)currentMode duration:(CGFloat)duration;

- (void)updateAppearance;

@end
