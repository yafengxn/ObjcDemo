//
//  Foundation+XNExtension.m
//  runtime实现方法替换
//
//  Created by 冯小宁 on 15/8/31.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//
/**
 * 说明：此分类使用runtime机制对NSMutableArray 的addObject:、objectAtIndex:以及NSArray 的objectAtIndex:方法进行替换，防止添加nil对象、访问元素数组的越界的情况下崩溃。
 * 使用：直接将此分类拖进工程即可，这样使用addObject、objectAtIndex时就不会因为添加nil对象和访问数组下表越界而导致程序崩溃
 * 注意：使用此分类可以保持应用程序在add nil对象、数组下标越界时不崩溃，但是这种做法不一定总是好事。
 */

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@implementation NSObject(XNExtension)
+ (void)swizzleClassMethod:(Class)class otherMethod:(SEL)otherMethodSelector originMethod:(SEL)originMethodSelector
{
    Method otherMethod = class_getClassMethod(class, otherMethodSelector);
    Method originMethod = class_getClassMethod(class, originMethodSelector);
    
    method_exchangeImplementations(otherMethod, originMethod);
}

+ (void)swizzleInstanceMethod:(Class)class otherMethod:(SEL)otherMethodSelector originMethod:(SEL)originMethodSelector
{
    Method otherMethod = class_getInstanceMethod(class, otherMethodSelector);
    Method originMethod = class_getInstanceMethod(class, originMethodSelector);
    
    method_exchangeImplementations(otherMethod, originMethod);
}
@end


@implementation NSArray (XNExtension)
+ (void)load
{
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayI") otherMethod:@selector(xn_objectAtIndex:) originMethod:@selector(objectAtIndex:)];
}

- (id)xn_objectAtIndex:(NSUInteger)index
{
    if(index < self.count) {
        return [self xn_objectAtIndex:index];
    } else {
        return nil;
    }
}
@end

@implementation NSMutableArray (XNExtension)
+ (void)load
{
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") otherMethod:@selector(xn_addObject:) originMethod:@selector(addObject:)];
    
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") otherMethod:@selector(xn_objectAtIndex:) originMethod:@selector(objectAtIndex:)];
}

- (void)xn_addObject:(id)object
{
    if(object != nil) {
        [self xn_addObject:object];
    }
}

- (id)xn_objectAtIndex:(NSUInteger)index
{
    if(index < self.count) {
        return [self xn_objectAtIndex:index];
    } else {
        return nil;
    }
}
@end


