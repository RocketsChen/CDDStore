//
//  XWFilterAnimator+XWFlash.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/19.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWFilterAnimator.h"

@interface XWFilterAnimator (XWFlash)

- (void)xw_flashAnimationFor:(XWFilterTransitionView *)filterView transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration;
@end
