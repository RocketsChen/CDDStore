//
//  XWCoolAnimator+XWPageFlip.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCoolAnimator.h"

@interface XWCoolAnimator (XWPageFlip)
- (void)xw_setPageFlipToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)xw_setPageFlipBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;
@end
