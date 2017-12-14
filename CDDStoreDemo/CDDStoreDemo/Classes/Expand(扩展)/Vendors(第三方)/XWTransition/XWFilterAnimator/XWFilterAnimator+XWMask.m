//
//  XWFilterAnimator+XWMask.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWFilterAnimator+XWMask.h"

@implementation XWFilterAnimator (XWMask)

- (void)xw_maskAnimationFor:(XWFilterTransitionView *)filterView transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration {
    CGFloat height = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.frame.size.height;
    CIImage *maskImg = self.maskImg ? [CIImage imageWithCGImage:self.maskImg.CGImage] : [CIImage imageWithCGImage:[UIImage imageNamed:@"mask.jpg"].CGImage];
    CIFilter *filter = [CIFilter filterWithName: @"CIDisintegrateWithMaskTransition"
                                  keysAndValues:
                        kCIInputMaskImageKey, maskImg,
                        @"inputShadowRadius", @10.0,
                        @"inputShadowDensity", @0.7,
                        @"inputShadowOffset", [CIVector vectorWithX:0.0  Y:-0.05 * height],
                        nil];
    filterView.filter = filter;
    [XWFilterTransitionView xw_animationWith:filterView duration:duration completion:^(BOOL finished) {
        [filterView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
