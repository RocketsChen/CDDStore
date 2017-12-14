//
//  CDDTopTip.h
//  CDDTopTip
//
//  Created by 李松 on 2017/10/16.
//  Copyright © 2017年 Squirrel. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CDDTopTip : NSObject


/**
 *  显示普通信息
 */
+ (void)showTopTipWithMessage:(NSString *)msg;


/**
 *  自定义颜色/尺寸显示提示框
 */
+ (void)showTopTipWithTipBgColor:(UIColor *)tipBgColor MsgColor:(UIColor *)msgColor MsgFont:(NSInteger)msgFontNum Msg:(NSString *)msg;

/**
 *  隐藏
 */
+ (void)hideTopTip;

@end
