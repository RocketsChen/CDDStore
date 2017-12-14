//
//  XWFilterAnimator+XWMod.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/19.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWFilterAnimator+XWMod.h"

@implementation XWFilterAnimator (XWMod)

- (void)xw_modAnimationFor:(XWFilterTransitionView *)filterView transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration toFlag:(BOOL)flag{
    CGFloat angle = self.revers && !flag ? self.startAngle + M_PI : self.startAngle;
    CIVector *vector = [filterView xw_getInnerVector];
    CIFilter *filter = [CIFilter filterWithName: @"CIModTransition"
                                  keysAndValues:
                        kCIInputCenterKey,[CIVector vectorWithX:0.5 * vector.CGRectValue.size.width
                                                              Y:0.5 * vector.CGRectValue.size.height],
                        kCIInputAngleKey, @(angle),
                        kCIInputRadiusKey, @30.0,
                        @"inputCompression", @10.0,
                        nil];
    filterView.filter = filter;
    [XWFilterTransitionView xw_animationWith:filterView duration:duration completion:^(BOOL finished) {
        [filterView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
