//
//  UINavigationController+XWTransition.h
//  XWTADemo
//
//  Created by wazrx on 16/6/7.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWTransitionAnimator;

@interface UINavigationController (XWTransition)

/**
 *  通过指定的转场animator来push控制器，达到不同的转场效果
 *
 *  @param viewController 被push的控制器
 *  @param animator       转场Animator
 */
- (void)xw_pushViewController:(UIViewController *)viewController withAnimator:(XWTransitionAnimator *)animator;

@end
