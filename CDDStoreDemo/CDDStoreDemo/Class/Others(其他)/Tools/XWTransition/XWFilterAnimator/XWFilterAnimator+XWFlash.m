//
//  XWFilterAnimator+XWFlash.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/19.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWFilterAnimator+XWFlash.h"

@implementation XWFilterAnimator (XWFlash)

- (void)xw_flashAnimationFor:(XWFilterTransitionView *)filterView transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration{
    CGSize size = filterView.frame.size;
    CIFilter *filter = [CIFilter filterWithName:@"CIFlashTransition"
                                  keysAndValues:
                        kCIInputCenterKey, [CIVector vectorWithCGPoint:CGPointMake(size.width, size.height)],
                        kCIInputColorKey, [CIColor colorWithRed:1.0 green:0.8 blue:0.6 alpha:1],
                        @"inputMaxStriationRadius", @2.5,
                        @"inputStriationStrength", @0.5,
                        @"inputStriationContrast", @1.37,
                        @"inputFadeThreshold", @0.5,
                        nil];
    filterView.filter = filter;
    [XWFilterTransitionView xw_animationWith:filterView duration:duration completion:^(BOOL finished) {
        [filterView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
