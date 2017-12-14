//
//  XWFilterAnimator+XWSwipe.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWFilterAnimator+XWSwipe.h"

@implementation XWFilterAnimator (XWSwipe)

- (void)xw_swipeAnimationFor:(XWFilterTransitionView *)filterView transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration toFlag:(BOOL)flag {
    CGFloat angle = self.revers && !flag ? self.startAngle + M_PI : self.startAngle;
    CIVector *vector = [filterView xw_getInnerVector];
    CIFilter *filter = [CIFilter filterWithName:@"CISwipeTransition"
                                  keysAndValues:
                        kCIInputExtentKey, vector,
                        kCIInputColorKey, [CIColor colorWithRed:0 green:0 blue:0 alpha:0],
                        kCIInputAngleKey, @(angle),
                        kCIInputWidthKey, @80.0,
                        @"inputOpacity", @0.0,
                        nil];
    filterView.filter = filter;
    [XWFilterTransitionView xw_animationWith:filterView duration:duration completion:^(BOOL finished) {
        [filterView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
