//
//  XWCoolAnimator+XWVerticalLines.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCoolAnimator.h"

@interface XWCoolAnimator (XWLines)


- (void)xw_setLinesToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext vertical:(BOOL)vertical;

- (void)xw_setLinesBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext vertical:(BOOL)vertical;

@end
