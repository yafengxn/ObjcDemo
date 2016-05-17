//
//  YCHamburgerButton.m
//  HamburgerButtonDemo
//
//  Created by yafengxn on 16/5/17.
//  Copyright © 2016年 yafengxn. All rights reserved.
//

#import "YCHamburgerButton.h"

@interface YCHamburgerButton()
@property (nonatomic, strong) CAShapeLayer *topLayer;
@property (nonatomic, strong) CAShapeLayer *middleLayer;
@property (nonatomic, strong) CAShapeLayer *bottomLayer;

@property (nonatomic, assign) CGRect lastBounds;
@end

@implementation YCHamburgerButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor grayColor];
    self.lineColor = [UIColor blueColor];
    self.lineHeight = 3;
    self.lineSpacing = 5;
    self.lineWidth  = 30;
    
    self.animationDurtion = .3;
    
    self.currentMode = YCHamburgerButtonModeHamburger;
    
    [self updateAppearance];
}

- (void)setCurrentMode:(YCHamburgerButtonMode)currentMode
{
    if (self.currentMode == currentMode) {
        return;
    }
    self->_currentMode = currentMode;
    [self updateAppearance];
}

- (void)setCurrentModeWithAnimation:(YCHamburgerButtonMode)currentMode
{
    [self setCurrentModeWithAnimation:currentMode duration:self.animationDurtion];
}

- (void)setCurrentModeWithAnimation:(YCHamburgerButtonMode)currentMode duration:(CGFloat)duration
{
    if (self.currentMode == currentMode) {
        return;
    }
    
    switch (self.currentMode) {
        case YCHamburgerButtonModeHamburger:
            switch (currentMode) {
                case YCHamburgerButtonModeHamburger:
                    // do nothing
                    break;
                case YCHamburgerButtonModeCross:
                    // hamburger --> cross
                    [self transformModeHamburgerToCross:duration];
                    break;
                default:
                    break;
            }
            break;
        case YCHamburgerButtonModeCross:
            switch (currentMode) {
                case YCHamburgerButtonModeHamburger:
                    // cross -->hamburger
                    [self transformModeCrossToHamburger:duration];
                    break;
                case YCHamburgerButtonModeCross:
                    // do nothing
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    self->_currentMode = currentMode;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!CGRectEqualToRect(_lastBounds, self.bounds)) {
        [self updateAppearance];
    }
}

- (void)updateAppearance
{
    _lastBounds = self.bounds;
    
    [_topLayer removeFromSuperlayer];
    [_middleLayer removeFromSuperlayer];
    [_bottomLayer removeFromSuperlayer];
    
    CGFloat x = CGRectGetWidth(self.frame) / 2.;
    {
        CGFloat y = (CGRectGetHeight(self.frame) / 2.) - self.lineHeight - self.lineSpacing;
        _topLayer = [self createLayer];
        _topLayer.position = CGPointMake(x, y);
    }
    {
        CGFloat y = CGRectGetHeight(self.frame) / 2.;
        _middleLayer = [self createLayer];
        _middleLayer.position = CGPointMake(x, y);
    }
    {
        CGFloat y = (CGRectGetHeight(self.frame) / 2.) + self.lineHeight + self.lineSpacing;
        _bottomLayer = [self createLayer];
        _bottomLayer.position = CGPointMake(x, y);
    }
    
    switch (self.currentMode) {
        case YCHamburgerButtonModeHamburger:
            [self transformModeHamburger];
            break;
        case YCHamburgerButtonModeCross:
            [self transformModeCross];
        default:
            break;
    }

}
- (CAShapeLayer *)createLayer
{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.lineWidth, 0)];
    
    layer.path = path.CGPath;
    layer.lineWidth = self.lineHeight;
    layer.strokeColor = self.lineColor.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapRound, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    
    [self.layer addSublayer:layer];
    
    return layer;
}

#pragma mark - Transform with aimation
- (void)transformModeHamburger
{
    _topLayer.transform = CATransform3DIdentity;
    _middleLayer.transform = CATransform3DIdentity;
    _bottomLayer.transform = CATransform3DIdentity;
}

- (void)transformModeCross
{
    {
        CGFloat angle = M_PI_4;
        
        CGFloat translateY = _middleLayer.position.y - _topLayer.position.y;
        
        CATransform3D t = CATransform3DIdentity;
        t = CATransform3DTranslate(t, 0, translateY, 0);
        t = CATransform3DTranslate(t, angle, 0, 1);
        
        _topLayer.transform = t;
    }
    {
        CATransform3D t = CATransform3DIdentity;
        t = CATransform3DScale(t, 0, 1., 1.);
        
        _middleLayer.transform = t;
    }
    {
        CGFloat angle = -M_PI_4;
        
        CGFloat translateY = _middleLayer.position.y - _bottomLayer.position.y;
        
        CATransform3D t = CATransform3DIdentity;
        t = CATransform3DTranslate(t, 0, translateY, 0);
        t = CATransform3DRotate(t, angle, 0, 0, 1);
        
        _bottomLayer.transform = t;
    }
}

#pragma mark - Transform with animation
- (void)transformModeHamburgerToCross:(CGFloat)duration
{
    {
        CAKeyframeAnimation *animation = [self createKeyFrameAnimation:duration];
        animation.values = [self hamburgerToCrossValuesTopLayer];
        [_topLayer addAnimation:animation forKey:@"transform"];
    }
    {
        CAKeyframeAnimation *animation = [self createKeyFrameAnimation:duration];
        animation.values = [self hamburgerToCrossValuesMiddleLayer];
        [_middleLayer addAnimation:animation forKey:@"transform"];
    }
    {
        CAKeyframeAnimation *animation = [self createKeyFrameAnimation:duration];
        animation.values = [self hamburgerToCrossValuesBottomLayer];
        [_bottomLayer addAnimation:animation forKey:@"transform"];
    }
}

- (void)transformModeCrossToHamburger:(CGFloat)duration
{
    {
        CAKeyframeAnimation *animation = [self createKeyFrameAnimation:duration];
        animation.values = [self reverseValues:[self hamburgerToCrossValuesTopLayer]];
        [_topLayer addAnimation:animation forKey:@"transform"];
    }
    {
        CAKeyframeAnimation *animation = [self createKeyFrameAnimation:duration];
        animation.values = [self reverseValues:[self hamburgerToCrossValuesMiddleLayer]];
        [_middleLayer addAnimation:animation forKey:@"transform"];
    }
    {
        CAKeyframeAnimation *animation = [self createKeyFrameAnimation:duration];
        animation.values = [self reverseValues:[self hamburgerToCrossValuesBottomLayer]];
        [_bottomLayer addAnimation:animation forKey:@"transform"];
    }
}

- (CAKeyframeAnimation *)createKeyFrameAnimation:(CGFloat)duration
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

- (NSArray *)reverseValues:(NSArray *)values
{
    NSMutableArray *newValues = [values mutableCopy];
    newValues = [[[newValues reverseObjectEnumerator] allObjects] mutableCopy];
    
    return newValues;
}

#pragma mark - 
- (NSArray *)hamburgerToCrossValuesTopLayer
{
    CGFloat NUMBER_VALUES = 4;
    
    CGFloat endAngle = M_PI_4;
    
    NSMutableArray *values = [NSMutableArray new];
    
    for (int i=0; i<NUMBER_VALUES; i++) {
        CGFloat angle = endAngle / (NUMBER_VALUES - 1.) * i;
        
        CATransform3D t = CATransform3DIdentity;
        
        CGFloat translateY = _middleLayer.position.y - _topLayer.position.y;
        translateY *= i / (NUMBER_VALUES - 1.);
        
        t = CATransform3DTranslate(t, 0, translateY, 0);
        t = CATransform3DRotate(t, angle, 0, 0, 1);
        
        NSValue *value = [NSValue valueWithCATransform3D:t];
        [values addObject:value];
    }
    return values;
}

- (NSArray *)hamburgerToCrossValuesMiddleLayer
{
    CGFloat NUMBER_VALUES = 4;
    
    CGFloat startScaleFactor = 1.;
    CGFloat endScaleFactor = .0;
    
    NSMutableArray *values = [NSMutableArray new];
    
    for(int i = 0; i < NUMBER_VALUES; ++i){
        CGFloat scaleFactor = startScaleFactor + (endScaleFactor - startScaleFactor) * i / (NUMBER_VALUES - 1.);
        
        CATransform3D t = CATransform3DIdentity;
        t = CATransform3DScale(t, scaleFactor, 1., 1.);
        
        NSValue *value = [NSValue valueWithCATransform3D:t];
        [values addObject:value];
    }
    
    return values;
}

- (NSArray *)hamburgerToCrossValuesBottomLayer
{
    CGFloat NUMBER_VALUES = 4;
    
    CGFloat endAngle = - M_PI_4;
    
    NSMutableArray *values = [NSMutableArray new];
    
    for(int i = 0; i < NUMBER_VALUES; ++i){
        CGFloat angle = endAngle / (NUMBER_VALUES - 1.) * i;
        
        CATransform3D t = CATransform3DIdentity;
        
        CGFloat translateY = _middleLayer.position.y - _bottomLayer.position.y;
        translateY *= i / (NUMBER_VALUES - 1.);
        
        t = CATransform3DTranslate(t, 0, translateY, 0);
        t = CATransform3DRotate(t, angle, 0, 0, 1);
        
        NSValue *value = [NSValue valueWithCATransform3D:t];
        [values addObject:value];
    }
    
    return values;
}

@end
