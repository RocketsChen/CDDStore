
//
//  XWFilterAnimator+XWPageCurl.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/19.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWFilterAnimator+XWPageCurl.h"

@implementation XWFilterAnimator (XWPageCurl)

- (void)xw_pageCurlAnimationFor:(XWFilterTransitionView *)filterView transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration toFlag:(BOOL)flag{
    CGFloat angle = self.revers && !flag ? self.startAngle + M_PI : self.startAngle;
    CIFilter *filter = [CIFilter filterWithName: @"CIPageCurlWithShadowTransition"
                                  keysAndValues:
                        kCIInputAngleKey, @(angle),
                        nil];
    filterView.filter = filter;
    [XWFilterTransitionView xw_animationWith:filterView duration:duration completion:^(BOOL finished) {
        [filterView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
