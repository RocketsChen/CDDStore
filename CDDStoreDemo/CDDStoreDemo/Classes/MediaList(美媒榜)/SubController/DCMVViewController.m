

//
//  DCMVViewController.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/12/4.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCMVViewController.h"

// Controllers

// Models

// Views

// Vendors
#import <WebKit/WebKit.h>
// Categories

// Others

@interface DCMVViewController ()

@property (strong, nonatomic) UIView *contentView;

@property (weak, nonatomic) WKWebView *webView;

@property (weak, nonatomic) UIProgressView *progressView;

@end

@implementation DCMVViewController


#pragma mark - 初始化
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpStarWebView];
    
    [self setUpProgress];
    
    [self setUpStarWebView];
    
    [self setUpNote];
}

#pragma mark - 初始化WebView
- (void)setUpStarWebView
{
    
    WKWebView *webView = [[WKWebView alloc]init];
    webView.backgroundColor = [UIColor whiteColor];
    self.webView = webView;
    [self.view insertSubview:webView atIndex:0];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    //加载数据
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [webView loadRequest:request];
    
}
#pragma mark - 初始化进度条
- (void)setUpProgress
{
    UIProgressView *progressView = [[UIProgressView alloc]init];
    progressView.progress = 0;
    _progressView = progressView;
    progressView.trackTintColor = [UIColor clearColor];
    progressView.tintColor = [UIColor redColor];
    [self.view addSubview:progressView];
    
}

#pragma mark - 通知
- (void)setUpNote
{
    //进度条观察者
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark - 观察新值改变
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}

-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.webView = nil;
    self.webView.navigationDelegate = nil;
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = CGRectMake(0, 0, self.view.dc_width, self.view.dc_height - 49);
    self.progressView.frame = CGRectMake(0, 0, ScreenW, 1.5);
}

@end
