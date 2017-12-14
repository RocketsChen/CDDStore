//
//  CDDTopTip.m
//  CDDTopTip
//
//  Created by 李松 on 2017/10/16.
//  Copyright © 2017年 Squirrel. All rights reserved.
//

#import "CDDTopTip.h"


@interface CDDTopTip ()

@end

/** 全局窗口 */
static UIWindow *window_;
/** 定时器 */
static NSTimer *timer_;
/** 提示信息显示时长 */
static CGFloat const DCMessageDuration = 2.0;
/** 提示信息显示\隐藏的动画时间间隔 */
static CGFloat const DCAnimationDuration = 0.25;

@implementation CDDTopTip


#pragma mark - 初始化窗口
+ (void)showWindowWithBgColor:(UIColor *)bgColor
{
    CGFloat windowH = 64;
    CGFloat windowW = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = CGRectMake(0, - windowH, windowW, windowH);
    
    window_.hidden = YES;
    window_ = [UIWindow new];
    window_.frame = frame;
    window_.windowLevel = UIWindowLevelNormal;  //设置windowLevel的窗口的等级
    window_.backgroundColor = (bgColor == nil) ?  [UIColor lightGrayColor] : bgColor;
    window_.hidden = NO;
    
    frame.origin.y = 0;
    [UIView animateWithDuration:DCAnimationDuration animations:^{
        window_.frame = frame;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }];
}

#pragma mark - 自定义顶部消息
+ (void)showTopTipWithTipBgColor:(UIColor *)tipBgColor MsgColor:(UIColor *)msgColor MsgFont:(NSInteger)msgFontNum Msg:(NSString *)msg
{
    if (msg.length == 0) return;  //如果没有提示信息直接返回
    //停止定时器
    [timer_ invalidate];
    
    //显示窗口
    [self showWindowWithBgColor:tipBgColor];
    
    [self setUpContentWithMsgColor:msgColor MsgFont:msgFontNum Msg:msg]; //设置中间提示文本
    
    //定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:DCMessageDuration target:self selector:@selector(hideTopTip) userInfo:nil repeats:NO];
}


#pragma mark - 默认显示
+ (void)showTopTipWithMessage:(NSString *)msg
{
    //停止定时器
    [timer_ invalidate];
    
    //显示窗口
    [self showWindowWithBgColor:nil];
    
    [self setUpContentWithMsgColor:nil MsgFont:0 Msg:msg]; //设置中间提示文本
    
    //定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:DCMessageDuration target:self selector:@selector(hideTopTip) userInfo:nil repeats:NO];
    
}


#pragma mark - 设置中间提示文本
+ (void)setUpContentWithMsgColor:(UIColor *)msgColor MsgFont:(NSInteger)msgFontNum Msg:(NSString *)msg
{
    //添加显示信息按钮
    UILabel *tipLabel = [UILabel new];
    tipLabel.text = msg;
    tipLabel.font = (msgFontNum == 0) ? [UIFont systemFontOfSize:18] : [UIFont systemFontOfSize:msgFontNum];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = (msgColor == nil) ? [UIColor whiteColor] : msgColor ;
    tipLabel.frame = CGRectMake(0, 20, window_.frame.size.width, window_.frame.size.height - 20);
    
    [window_ addSubview:tipLabel];
}


#pragma mark - 隐藏提示框
+ (void)hideTopTip
{
    [UIView animateWithDuration:DCAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = - frame.size.height;
        window_.frame = frame;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
    }];
}

@end
