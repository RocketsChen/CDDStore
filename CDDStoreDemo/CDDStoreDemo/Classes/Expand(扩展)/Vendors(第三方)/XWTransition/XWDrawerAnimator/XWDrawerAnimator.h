//
//  XWDrawerAnimator.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/15.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWTransitionAnimator.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XWDrawerAnimatorDirection) {
    XWDrawerAnimatorDirectionLeft,
    XWDrawerAnimatorDirectionRight,
    XWDrawerAnimatorDirectionTop,
    XWDrawerAnimatorDirectionBottom
};

@interface XWDrawerAnimator : XWTransitionAnimator

/**fromVC的缩放比例， 如果Flip效果，比例默认为0.8， 否者为1.0不缩放*/
@property (nonatomic, assign) CGFloat scaleRatio;
/**视差效果，类似于QQ的设置界面弹出效果, 和flipEnable只能选择其一，如果都设置为YES，后设置的生效*/
@property (nonatomic, assign) BOOL parallaxEnable;
/**翻转效果，类似于淘宝选择规格时，后面视图的动画效果*/
@property (nonatomic, assign) BOOL flipEnable;

/**
 *  初始化一个转场抽屉效果器
 *
 *  @param direction 抽屉效果触发方向
 *  @param distance  显示在屏幕中的宽度或者高度，如果传0，默认就是当前屏幕的高度或者宽度
 *
 *  @return animator
 */
+ (instancetype)xw_animatorWithDirection:(XWDrawerAnimatorDirection)direction moveDistance:(CGFloat)distance;

/**
 *  开启边缘(就是屏幕除开toView所占用的部分)back手势和边缘点击返回效果，类似于QQ设置界面的返回效果
 *
 *  @param backConfig 返回操作，您的dismiss或者pop操作
 */
- (void)xw_enableEdgeGestureAndBackTapWithConfig:(dispatch_block_t)backConfig;

@end

NS_ASSUME_NONNULL_END