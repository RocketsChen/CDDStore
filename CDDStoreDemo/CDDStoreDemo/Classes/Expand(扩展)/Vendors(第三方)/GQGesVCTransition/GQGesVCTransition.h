//
//  GQPanVCTransition.h
//  GQPanVCTransitionDemo
//
//  Created by tusm on 16/4/30.
//  Copyright © 2016年 gaoqi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef enum {
    GQGesVCTransitionTypePanWithPercentRight,           //全屏向左拖动模式 百分比从右开始计算
    GQGesVCTransitionTypePanWithPercentLeft,            //全屏向左拖动模式 百分比从左开始计算
    GQGesVCTransitionTypeScreenEdgePan                  //向左边界拖动模式
} GQGesVCTransitionType;//手势类型

@interface GQGesVCTransition : NSObject

/**
 *  精简代码:全部设置默认值
 */
+ (void)validateGesBack;

/**
 *   精简代码模式
 *
 *  @param type        拖拽模式  默认为全屏向左拖动模式 百分比从左开始计算
 *  @param requestFail 界面中scrollview滑动到左边界时是否响应返回手势  默认为NO
 */
+ (void)validateGesBackWithType:(GQGesVCTransitionType)type withRequestFailToLoopScrollView:(BOOL)requestFail;

/**
 *  精简代码模式
 *
 *  @param type 拖拽模式  默认为全屏向左拖动模式 百分比从左开始计算
 *  @param percent     屏幕响应手势百分比  默认全屏
 */
+ (void)validateGesBackWithType:(GQGesVCTransitionType)type withScreenWidthPercent:(NSNumber *)percent;

/**
*  全局开启手势返回模式
*
*  @param type        拖拽模式  默认为全屏向左拖动模式 百分比从左开始计算
*  @param percent     屏幕响应手势百分比  默认全屏
*  @param requestFail 界面中scrollview滑动到左边界时是否响应返回手势  默认为NO
*/
+ (void)validateGesBackWithType:(GQGesVCTransitionType)type withScreenWidthPercent:(NSNumber *)percent withRequestFailToLoopScrollView:(BOOL)requestFail;

@end

@interface UIView(__GQGesVCTransition)

/**
 *  设置View不响应我们的手势
 */
- (void)disableGQVCTransition;

/**
 *  设置View响应我们的手势
 */
- (void)enableGQVCTransition;

@end

@interface UINavigationController(DisableVCTransition)

/**
 *  设置导航控制器是否响应手势，默认YES
 *
 *  @param enabled YES OR NO
 */
- (void)enabledGQVCTransition:(BOOL)enabled;

@end