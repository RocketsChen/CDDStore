//
//  XWCoolAnimator+XWScanning.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCoolAnimator.h"

@interface XWCoolAnimator (XWScanning)


- (void)xw_setScanningToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext direction:(NSUInteger)direction;

- (void)xw_setScanningBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext direction:(NSUInteger)direction;
@end
