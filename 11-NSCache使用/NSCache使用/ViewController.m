//
//  ViewController.m
//  NSCache使用
//
//  Created by 冯小宁 on 15/9/11.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSCacheDelegate>
/** cache */
@property (nonatomic, strong) NSCache *cache;
@end

@implementation ViewController

- (NSCache *)cache
{
    if(_cache == nil) {
        _cache = [[NSCache alloc] init];
        // 总数量限额
        _cache.countLimit = 6;
        // 设置代理
        _cache.delegate = self;
    }
    return _cache;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(int i=0; i<20; ++i) {
        NSString *str = [NSString stringWithFormat:@"cache --- %04zd", i];
        
        // 添加到缓存，只要超出限额，立即删除最早的一个对象
        [self.cache setObject:str forKey:@(i)];
    }
    
    NSLog(@"---------");
    // 遍历仅用于测试，实际开发中都是根据key来取值
    // 遍历时因为有些key不存在，所以输出为null
    for(int i=0; i<20; ++i) {
        NSLog(@"%@", [self.cache objectForKey:@(i)]);
    }
}

#pragma mark - <NSCacheDelegate>
// NSCache一清理缓存，就会调用这个方法
// *** 这个代理方法，仅供测试了解NSCache的缓存机制，实际开发中不要实现，否则会
// 严重影响缓存的执行性能
- (void)cache:(NSCache *)cache willEvictObject:(id)obj
{
    NSLog(@"remove --- %@", obj);
}
@end
