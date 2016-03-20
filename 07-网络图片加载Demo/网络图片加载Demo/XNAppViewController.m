//
//  XNAppViewController.m
//  加载网络图片Demo
//
//  Created by 冯小宁 on 15/9/9.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "XNAppViewController.h"
#import "XNAppInfo.h"
@interface XNAppViewController ()
/** applist */
@property (nonatomic, strong) NSMutableArray *appList;

/** operationQueue */
@property (nonatomic, strong) NSOperationQueue *queue;

/** operationCache：操作缓冲池 */
@property (nonatomic, strong) NSMutableDictionary *operationCache;

/** imageCache：图片缓冲池 */
@property (nonatomic, strong) NSMutableDictionary *imageCache;

@end

@implementation XNAppViewController
- (NSMutableDictionary *)imageCache
{
    if(_imageCache == nil) {
        _imageCache = [[NSMutableDictionary alloc] init];
    }
    return _imageCache;
}

- (NSOperationQueue *)queue
{
    if(_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (NSMutableDictionary *)operationCache
{
    if(_operationCache == nil) {
        _operationCache = [[NSMutableDictionary alloc] init];
    }
    return _operationCache;
}

- (NSMutableArray *)appList
{
    if(_appList == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        // 每次增加array.count个元素
        _appList = [NSMutableArray arrayWithCapacity:array.count];
        
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            XNAppInfo *appInfo = [XNAppInfo appInfoWithDict:obj];
            [_appList addObject:appInfo];
        }];
    }
    return _appList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//  当我们想要调整tableView中cell(不勾选自定义，使用系统的)的高度时，我们不能去设置rowHeight，而应该是直接拖动方法cell即可。
//    self.tableView.rowHeight = 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // 清理缓存
    [self.operationCache removeAllObjects];
    [self.imageCache removeAllObjects];
    
    // 取消所有下载操作
    [self.queue cancelAllOperations];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"appInfo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
    }
    
    XNAppInfo *appInfo = self.appList[indexPath.row];
    cell.textLabel.text = appInfo.name;
    cell.detailTextLabel.text = appInfo.download;
    
    if(self.imageCache[appInfo.icon]) {
        // 图片缓存中有，直接使用
        cell.imageView.image = self.imageCache[appInfo.icon];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"user_default"];
        
        // 没有，下载图片
        [self downloadImage:indexPath];
    }
    
    return cell;
}

- (void)downloadImage:(NSIndexPath *)indexPath
{
    XNAppInfo *appInfo = self.appList[indexPath.row];
    
    if(self.operationCache[appInfo.icon]) {
        NSLog(@"正在玩命下载中 --- 请稍候");
        return;
    }
    
    NSBlockOperation *oper = [NSBlockOperation blockOperationWithBlock:^{
        // 下载图片
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:appInfo.icon]];
        UIImage *image = [UIImage imageWithData:data];
        
        // 设置图片缓冲
        if(image) { // 当图片下载成功，才往图片缓冲区中保存
            self.imageCache[appInfo.icon] = image;
        }
        
        // 下载完毕，将下载操作从下载缓冲池中移除
        /**
         1.可以节约内存
         2.如果下载失败，可以重试
         3.可以避免出现循环引用
         */
        [self.operationCache removeObjectForKey:appInfo.icon];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if(image) {
                // 设置图片并刷新UI
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }];
    
    [self.queue addOperation:oper];
    
    // 将操作放入缓冲池
    [self.operationCache setObject:oper forKey:appInfo.icon];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"operationCache --- %@", self.operationCache);
}

- (void)dealloc
{
    NSLog(@"XNAppViewController --- dealloc");
}

@end
