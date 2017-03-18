//
//  XWFilterAnimator+XWBoxBlur.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWFilterAnimator+XWBoxBlur.h"

@implementation XWFilterAnimator (XWBoxBlur)

- (void)xw_boxBlurAnimationFor:(XWFilterTransitionView *)filterView transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration {
    CIFilter *filter = [CIFilter filterWithName: @"CIBoxBlur"];
    filterView.filter = filter;
    filterView.blurType = YES;
    [XWFilterTransitionView xw_animationWith:filterView duration:duration completion:^(BOOL finished) {
        [filterView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}
@end
