//
//  XWCoolAnimator+XWFold.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCoolAnimator+XWFold.h"
#import "UIView+Snapshot.h"

@implementation XWCoolAnimator (XWFold)

- (void)xw_setFoldToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext leftFlag:(BOOL)left {
    [self _xw_animation:transitionContext flag:left duration:self.toDuration];
    
}

- (void)xw_setFoldBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext leftFlag:(BOOL)left {
    [self _xw_animation:transitionContext flag:left duration:self.backDuration];
    
}

- (void)_xw_animation:(id<UIViewControllerContextTransitioning>)transitionContext flag:(BOOL)flag duration:(NSTimeInterval)duration{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    UIView *containerView = [transitionContext containerView];
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    toView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0);
    [containerView addSubview:toView];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.005;
    containerView.layer.sublayerTransform = transform;
    CGSize size = toView.frame.size;
    float foldWidth = size.width * 0.5 / (float)self.foldCount ;
    NSMutableArray* fromViewFolds = [NSMutableArray new];
    NSMutableArray* toViewFolds = [NSMutableArray new];
    UIImage *fromImage = fromView.snapshotImage;
    UIImage *toImage = toView.snapshotImage;
    for (int i=0 ;i<self.foldCount; i++){
        float offset = (float)i * foldWidth * 2;
        UIView *leftFromViewFold = [self _xw_createSnapshotFromView:fromView location:offset left:YES image:fromImage];
        leftFromViewFold.layer.position = CGPointMake(offset, size.height/2);
        [fromViewFolds addObject:leftFromViewFold];
        [leftFromViewFold.subviews[1] setAlpha:0.0];
        UIView *rightFromViewFold = [self _xw_createSnapshotFromView:fromView location:offset + foldWidth left:NO image:fromImage];
        rightFromViewFold.layer.position = CGPointMake(offset + foldWidth * 2, size.height/2);
        [fromViewFolds addObject:rightFromViewFold];
        [rightFromViewFold.subviews[1] setAlpha:0.0];
        UIView *leftToViewFold = [self _xw_createSnapshotFromView:toView location:offset left:YES image:toImage];
        leftToViewFold.layer.position = CGPointMake(!flag ? size.width : 0.0, size.height/2);
        leftToViewFold.layer.transform = CATransform3DMakeRotation(M_PI_2, 0.0, 1.0, 0.0);
        [toViewFolds addObject:leftToViewFold];
        UIView *rightToViewFold = [self _xw_createSnapshotFromView:toView location:offset + foldWidth left:NO image:toImage];
        rightToViewFold.layer.position = CGPointMake(!flag ? size.width : 0.0, size.height/2);
        rightToViewFold.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0.0, 1.0, 0.0);
        [toViewFolds addObject:rightToViewFold];
    }
    fromView.frame = CGRectOffset(fromView.frame, fromView.frame.size.width, 0);
    [UIView animateWithDuration:duration animations:^{
        for (int i=0; i<self.foldCount; i++){
            float offset = (float)i * foldWidth * 2;
            UIView* leftFromView = fromViewFolds[i*2];
            leftFromView.layer.position = CGPointMake(!flag ? 0.0 : size.width, size.height/2);
            leftFromView.layer.transform = CATransform3DRotate(transform, M_PI_2, 0.0, 1.0, 0);
            [leftFromView.subviews[1] setAlpha:1.0];
            UIView* rightFromView = fromViewFolds[i*2+1];
            rightFromView.layer.position = CGPointMake(!flag ? 0.0 : size.width, size.height/2);
            rightFromView.layer.transform = CATransform3DRotate(transform, -M_PI_2, 0.0, 1.0, 0);
            [rightFromView.subviews[1] setAlpha:1.0];
            UIView* leftToView = toViewFolds[i*2];
            leftToView.layer.position = CGPointMake(offset, size.height/2);
            leftToView.layer.transform = CATransform3DIdentity;
            [leftToView.subviews[1] setAlpha:0.0];
            UIView* rightToView = toViewFolds[i*2+1];
            rightToView.layer.position = CGPointMake(offset + foldWidth * 2, size.height/2);
            rightToView.layer.transform = CATransform3DIdentity;
            [rightToView.subviews[1] setAlpha:0.0];
        }
    }  completion:^(BOOL finished) {
        for (UIView *view in toViewFolds) {
            [view removeFromSuperview];
        }
        for (UIView *view in fromViewFolds) {
            [view removeFromSuperview];
        }
        
        BOOL transitionFinished = ![transitionContext transitionWasCancelled];
        if (transitionFinished) {
            toView.frame = containerView.bounds;
            fromView.frame = containerView.bounds;
        }
        else {
            fromView.frame = containerView.bounds;
        }
        [transitionContext completeTransition:transitionFinished];
    }];
}
- (UIView *)_xw_createSnapshotFromView:(UIView *)view location:(CGFloat)offset left:(BOOL)left image:(UIImage *)image{
    
    CGSize size = view.frame.size;
    UIView *containerView = view.superview;
    float foldWidth = size.width * 0.5 / (float)self.foldCount ;
    UIView *snapshotView = [UIView new];
    CGRect snapshotRegion = CGRectMake(offset, 0.0, foldWidth, size.height);
    snapshotView.frame = snapshotRegion;
    snapshotView.contentImage = image;
    snapshotView.layer.contentsRect = CGRectMake(offset / size.width, 0.0, foldWidth / size.width, 1.0f);
    UIView* snapshotWithShadowView = [self _xw_addShadowToView:snapshotView reverse:left];
    [containerView addSubview:snapshotWithShadowView];
    snapshotWithShadowView.layer.anchorPoint = CGPointMake( left ? 0.0 : 1.0, 0.5);
    
    return snapshotWithShadowView;
}

- (UIView *)_xw_addShadowToView:(UIView*)view reverse:(BOOL)reverse {
    UIView* viewWithShadow = [[UIView alloc] initWithFrame:view.frame];
    UIView* shadowView = [[UIView alloc] initWithFrame:viewWithShadow.bounds];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = shadowView.bounds;
    gradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:1.0].CGColor];
    gradient.startPoint = CGPointMake(reverse ? 0.0 : 1.0, reverse ? 0.2 : 0.0);
    gradient.endPoint = CGPointMake(reverse ? 1.0 : 0.0, reverse ? 0.0 : 1.0);
    [shadowView.layer insertSublayer:gradient atIndex:1];
    view.frame = view.bounds;
    [viewWithShadow addSubview:view];
    [viewWithShadow addSubview:shadowView];
    return viewWithShadow;
}

@end
