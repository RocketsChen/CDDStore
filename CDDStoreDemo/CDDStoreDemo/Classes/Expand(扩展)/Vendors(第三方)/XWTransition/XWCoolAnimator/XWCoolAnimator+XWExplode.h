//
//  XWCoolAnimator+XWExplode.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCoolAnimator.h"

@interface XWCoolAnimator (XWExplode)

- (void)xw_setExplodeToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)xw_setExplodeBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;
@end
