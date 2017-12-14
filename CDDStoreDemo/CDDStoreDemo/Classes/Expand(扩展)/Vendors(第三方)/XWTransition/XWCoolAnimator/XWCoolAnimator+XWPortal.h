//
//  XWCoolAnimator+XWPortal.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/16.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCoolAnimator.h"

@interface XWCoolAnimator (XWPortal)

- (void)xw_setPortalToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)xw_setPortalBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
