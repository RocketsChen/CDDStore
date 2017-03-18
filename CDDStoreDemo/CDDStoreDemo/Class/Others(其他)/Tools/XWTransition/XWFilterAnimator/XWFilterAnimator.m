//
//  XWFilterAnimator.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWFilterAnimator.h"
#import "XWFilterAnimator+XWBoxBlur.h"
#import "XWFilterAnimator+XWSwipe.h"
#import "XWFilterAnimator+XWBarSwipe.h"
#import "XWFilterAnimator+XWMask.h"
#import "XWFilterAnimator+XWFlash.h"
#import "XWFilterAnimator+XWMod.h"
#import "XWFilterAnimator+XWPageCurl.h"
#import "XWFilterAnimator+XWRipple.h"
#import "XWFilterAnimator+XWCopyMachine.h"

@implementation XWFilterAnimator{
    UIView *_containerView;
    XWFilterAnimatorType _type;
}



+ (instancetype)xw_animatorWithType:(XWFilterAnimatorType)type {
    return[[self alloc] _initWithType:type];
}

- (instancetype)_initWithType:(XWFilterAnimatorType)type{
    self = [super init];
    if (self) {
        _type = type;
        self.needInteractiveTimer = YES;
        _revers = YES;
    }
    return self;
}

- (void)xw_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    _containerView = containerView;
    [containerView addSubview:toVC.view];
    XWFilterTransitionView *filterView = [[XWFilterTransitionView alloc] initWithFrame:containerView.bounds fromImage:[self xw_ImageFromsnapshotView:fromVC.view] toImage:[self xw_ImageFromsnapshotView:toVC.view]];
    switch (_type) {
        case XWFilterAnimatorTypeBoxBlur: {
            [self xw_boxBlurAnimationFor:filterView transitionContext:transitionContext duration:self.toDuration];
            break;
        }
        case XWFilterAnimatorTypeSwipe: {
            [self xw_swipeAnimationFor:filterView transitionContext:transitionContext duration:self.toDuration toFlag:YES];
            break;
        }
        case XWFilterAnimatorTypeBarSwipe:{
            [self xw_barSwipeAnimationFor:filterView transitionContext:transitionContext duration:self.toDuration toFlag:YES];
            break;
        }
        case XWFilterAnimatorTypeMask:{
            [self xw_maskAnimationFor:filterView transitionContext:transitionContext duration:self.toDuration];
            break;
        }
        case XWFilterAnimatorTypeFlash:{
            [self xw_flashAnimationFor:filterView transitionContext:transitionContext duration:self.toDuration];
            break;
        }
        case XWFilterAnimatorTypeMod:{
            [self xw_modAnimationFor:filterView transitionContext:transitionContext duration:self.toDuration toFlag:YES];
            break;
        }
        case XWFilterAnimatorTypePageCurl:{
            [self xw_pageCurlAnimationFor:filterView transitionContext:transitionContext duration:self.toDuration toFlag:YES];
            break;
        }
        case XWFilterAnimatorTypeRipple:{
            [self xw_rippleAnimationFor:filterView transitionContext:transitionContext duration:self.toDuration];
            break;
        }
        case XWFilterAnimatorTypeCopyMachine:{
            [self xw_copyMachineAnimationFor:filterView transitionContext:transitionContext duration:self.toDuration toFlag:YES];
            break;
        }
    }
    [containerView addSubview:filterView];
}

- (void)xw_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view atIndex:0];
    _containerView = containerView;
    XWFilterTransitionView *filterView = [[XWFilterTransitionView alloc] initWithFrame:containerView.bounds fromImage:[self xw_ImageFromsnapshotView:fromVC.view] toImage:[self xw_ImageFromsnapshotView:toVC.view]];
    switch (_type) {
        case XWFilterAnimatorTypeBoxBlur: {
            [self xw_boxBlurAnimationFor:filterView transitionContext:transitionContext duration:self.backDuration];
            break;
        }
        case XWFilterAnimatorTypeSwipe: {
            [self xw_swipeAnimationFor:filterView transitionContext:transitionContext duration:self.backDuration toFlag:NO];
            break;
        }
        case XWFilterAnimatorTypeBarSwipe:{
            [self xw_barSwipeAnimationFor:filterView transitionContext:transitionContext duration:self.backDuration toFlag:NO];
            break;
        }
        case XWFilterAnimatorTypeMask:{
            [self xw_maskAnimationFor:filterView transitionContext:transitionContext duration:self.backDuration];
            break;
        }
        case XWFilterAnimatorTypeFlash:{
            [self xw_flashAnimationFor:filterView transitionContext:transitionContext duration:self.backDuration];
            break;
        }
        case XWFilterAnimatorTypeMod:{
            [self xw_modAnimationFor:filterView transitionContext:transitionContext duration:self.backDuration toFlag:NO];
            break;
        }
        case XWFilterAnimatorTypePageCurl:{
            [self xw_pageCurlAnimationFor:filterView transitionContext:transitionContext duration:self.backDuration toFlag:NO];
            break;
        }
        case XWFilterAnimatorTypeRipple:{
            [self xw_rippleAnimationFor:filterView transitionContext:transitionContext duration:self.backDuration];
            break;
        }
        case XWFilterAnimatorTypeCopyMachine:{
            [self xw_copyMachineAnimationFor:filterView transitionContext:transitionContext duration:self.backDuration toFlag:NO];
            break;
        }
    }
    [containerView addSubview:filterView];
}

- (UIImage *)xw_ImageFromsnapshotView:(UIView *)view{
    CALayer *layer = view.layer;
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)xw_interactiveTransitionWillBeginTimerAnimation:(XWInteractiveTransition *)interactiveTransition{
    _containerView.userInteractionEnabled = NO;
}

- (void)xw_interactiveTransition:(XWInteractiveTransition *)interactiveTransition willEndWithSuccessFlag:(BOOL)flag percent:(CGFloat)percent{
    _containerView.userInteractionEnabled = YES;
}

@end
