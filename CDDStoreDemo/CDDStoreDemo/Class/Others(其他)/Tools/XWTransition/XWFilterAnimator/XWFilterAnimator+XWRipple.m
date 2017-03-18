//
//  XWFilterAnimator+XWRipple.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/19.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWFilterAnimator+XWRipple.h"

@implementation XWFilterAnimator (XWRipple)

- (void)xw_rippleAnimationFor:(XWFilterTransitionView *)filterView transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration{
    CIImage *img = [CIImage imageWithCGImage:[UIImage imageNamed:@"restrictedshine.tiff"].CGImage];
    CIVector *vector = [filterView xw_getInnerVector];
    CIFilter *filter = [CIFilter filterWithName: @"CIRippleTransition"
                                  keysAndValues:
                        kCIInputShadingImageKey, img,
                        kCIInputCenterKey, [CIVector vectorWithX:0.5 * vector.CGRectValue.size.width
                                                               Y:0.5 * vector.CGRectValue.size.height],
                        nil];
    filterView.filter = filter;
    [XWFilterTransitionView xw_animationWith:filterView duration:duration completion:^(BOOL finished) {
        [filterView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
