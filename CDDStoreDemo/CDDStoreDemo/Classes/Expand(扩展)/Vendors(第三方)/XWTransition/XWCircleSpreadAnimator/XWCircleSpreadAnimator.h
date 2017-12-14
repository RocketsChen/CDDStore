//
//  XWCircleSpreadAnimator.h
//  XWTADemo
//
//  Created by wazrx on 16/6/7.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWTransitionAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWCircleSpreadAnimator : XWTransitionAnimator

/**
 *  返回一个小圆点扩散转场效果器
 *
 *  @param point  扩散开始中心
 *  @param radius 扩散开始的半径
 *
 *  @return 小圆点扩散转场效果器
 */
+ (instancetype)xw_animatorWithStartCenter:(CGPoint)point radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END