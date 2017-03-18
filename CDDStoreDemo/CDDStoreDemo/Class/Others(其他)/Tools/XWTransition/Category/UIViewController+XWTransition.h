//
//  UIViewController+XWTransition.h
//  XWTADemo
//
//  Created by wazrx on 16/6/7.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWTransitionAnimator.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XWTransition)


/**
 *  通过指定的转场animator来present控制器
 *
 *  @param viewController 被modal出的控制器
 *  @param animator       转场animator
 */
- (void)xw_presentViewController:(UIViewController *)viewController withAnimator:(XWTransitionAnimator *)animator;


#pragma  mark - 神奇移动相关

/**
 *  注册神奇移动起始视图
 *
 *  @param group 神奇移动起始视图数组
 */
- (void)xw_addMagicMoveStartViewGroup:(NSArray<UIView *> *)group;

 /**
 *  注册神奇移动终止视图
 *
 *  @param group 神奇移动终止视图数组，注意起始视图数组和终止视图数组的视图需要一一对应才能有正确的效果
 */
- (void)xw_addMagicMoveEndViewGroup:(NSArray<UIView *> *)group;

/**
 *  改变神奇移动起始视图，因为在back的时候，有可能不需要再回到原来起始的位置，需要去一个新的视图位置，所以在back前需要调用该方法改变起始视图数组
 *
 *  @param group 新的起始视图数组
 */
- (void)xw_changeMagicMoveStartViewGroup:(NSArray<UIView *> *)group;

#pragma mark - 手势相关

/**
 *  注册to手势(push或者Present手势)，block中的startPoint为手势开始时手指所在的点，在有些特殊需求的时候，你可能需要它
 *
 *  @param direction       手势方向
 *  @param tansitionConfig 手势触发的block，block中需要包含你的push或者Present的逻辑代码，注意避免循环引用问题
 *  @param edgeSpacing     手势触发的边缘距离，该值为0，表示在整个控制器视图上都有效，否者这在边缘的edgeSpacing之类有效
 */

- (void)xw_registerToInteractiveTransitionWithDirection:(XWInteractiveTransitionGestureDirection)direction transitonBlock:(void(^)(CGPoint startPoint))tansitionConfig edgeSpacing:(CGFloat)edgeSpacing;

/**
 *  注册back手势(pop或者dismiss手势)
 *
 *  @param direction       手势方向
 *  @param tansitionConfig 手势触发的block，block中需要包含你的pop或者dismiss的逻辑代码，注意避免循环引用问题
 *  @param edgeSpacing     手势触发的边缘距离，该值为0，表示在整个控制器视图上都有效，否者这在边缘的edgeSpacing之类有效
 */
- (void)xw_registerBackInteractiveTransitionWithDirection:(XWInteractiveTransitionGestureDirection)direction transitonBlock:(void(^)(CGPoint startPoint))tansitionConfig edgeSpacing:(CGFloat)edgeSpacing;

@end

UIKIT_EXTERN NSString *const kXWToInteractiveKey;
UIKIT_EXTERN NSString *const kXWAnimatorKey;

NS_ASSUME_NONNULL_END

