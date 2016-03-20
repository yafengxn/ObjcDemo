//
//  ViewController.m
//  URL中文转义
//
//  Created by 冯小宁 on 15/9/18.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    NSString *urlString = @"https://www.baidu.com/s?wd=电影剧照&rsv_spt=1&issp=1&f=8&rsv_bp=0&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_enter=1&rsv_sug3=8&rsv_sug1=8&rsv_sug6=11&sug=美女图片&rsv_n=1&rsv_t=1cdb43q0yne%2BbPS4062UZGKr8JOXx3l%2FC%2BZv%2BmRhAovH1vs3OK2PLp%2Bp4%2BpF5g%2FwolmF";
    // 如果请求中包含中文或空格要使用stringByAddingPercentEscapesUsingEncoding方法进行转义
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    self.webView.scalesPageToFit = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UIWebViewDelegate>
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@" error : %@ ", error);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}
@end
