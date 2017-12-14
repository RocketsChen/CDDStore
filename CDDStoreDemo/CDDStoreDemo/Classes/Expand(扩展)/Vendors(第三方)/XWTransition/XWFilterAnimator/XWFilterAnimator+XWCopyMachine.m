//
//  XWFilterAnimator+XWCopyMachine.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/19.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWFilterAnimator+XWCopyMachine.h"

@implementation XWFilterAnimator (XWCopyMachine)

- (void)xw_copyMachineAnimationFor:(XWFilterTransitionView *)filterView transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration toFlag:(BOOL)flag{
    CGFloat angle = self.revers && !flag ? self.startAngle + M_PI : self.startAngle;
    CIVector *vector = [filterView xw_getInnerVector];
    CIFilter *filter = [CIFilter filterWithName:@"CICopyMachineTransition"
                                  keysAndValues:
                        kCIInputExtentKey, vector,
                        kCIInputColorKey, [CIColor colorWithRed:.6 green:1 blue:.8 alpha:1],
                        kCIInputAngleKey, @(angle),
                        kCIInputWidthKey, @50.0,
                        @"inputOpacity", @1.0,
                        nil];
    filterView.filter = filter;
    [XWFilterTransitionView xw_animationWith:filterView duration:duration completion:^(BOOL finished) {
        [filterView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
