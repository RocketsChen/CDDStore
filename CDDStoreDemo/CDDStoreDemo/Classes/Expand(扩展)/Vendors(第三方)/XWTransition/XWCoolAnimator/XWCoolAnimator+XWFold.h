//
//  XWCoolAnimator+XWFold.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCoolAnimator.h"

@interface XWCoolAnimator (XWFold)

- (void)xw_setFoldToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext leftFlag:(BOOL)left;

- (void)xw_setFoldBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext leftFlag:(BOOL)left;
@end
