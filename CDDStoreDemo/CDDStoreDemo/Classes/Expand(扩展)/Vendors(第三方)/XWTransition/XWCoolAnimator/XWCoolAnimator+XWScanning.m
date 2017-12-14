//
//  XWCoolAnimator+XWScanning.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCoolAnimator+XWScanning.h"

@implementation XWCoolAnimator (XWScanning)

- (void)xw_setScanningToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext direction:(NSUInteger)direction {
    [self _xw_animateTransition:transitionContext duration:self.toDuration direction:direction];
    
}

- (void)xw_setScanningBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext direction:(NSUInteger)direction {
    [self _xw_animateTransition:transitionContext duration:self.toDuration direction:direction];
    
}

- (void)_xw_animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration direction:(NSInteger)direction{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view atIndex:0];
    UIView *maskView = [UIView new];
    maskView.backgroundColor = [UIColor whiteColor];
    maskView.frame = containerView.bounds;
    fromVC.view.maskView = maskView;
    UIView *scanView = [UIView new];
    scanView.layer.contents = (__bridge id)[UIImage imageNamed:@"line"].CGImage;
    [containerView addSubview:scanView];
    CGFloat width = containerView.frame.size.width;
    CGFloat height = containerView.frame.size.height;
    CGAffineTransform transfrom = CGAffineTransformIdentity;
    if (direction == 0){
        scanView.bounds = CGRectMake(0, 0, 18, height * 1.5);
        scanView.center = CGPointMake(-4, containerView.center.y);
        transfrom = CGAffineTransformMakeTranslation(width, 0);
    }
    if (direction == 1){
        scanView.bounds = CGRectMake(0, 0, 18, height * 1.5);
        scanView.center = CGPointMake(width + 4, containerView.center.y);
        transfrom = CGAffineTransformMakeTranslation(-width, 0);
    }
    if (direction == 2){
        scanView.bounds = CGRectMake(0, 0,width * 1.5, 18);
        scanView.center = CGPointMake(containerView.center.x, -4);
        transfrom = CGAffineTransformMakeTranslation(0, height);
    }
    if (direction == 3){
        scanView.bounds = CGRectMake(0, 0, width * 1.5, 18);
        scanView.center = CGPointMake(containerView.center.x, height + 4);
        transfrom = CGAffineTransformMakeTranslation(0, -height);
    }
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:0
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.7 animations:^{
                                      maskView.transform = transfrom;
                                      scanView.transform = transfrom;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
                                      scanView.transform = CGAffineTransformIdentity;
                                  }];
                                  
                              } completion:^(BOOL finished) {
                                  fromVC.view.maskView = nil;
                                  [scanView removeFromSuperview];
                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                              }];
    
}

@end
