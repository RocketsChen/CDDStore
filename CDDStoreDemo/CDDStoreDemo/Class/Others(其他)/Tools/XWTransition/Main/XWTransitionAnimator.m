//
//  XWTransitionAnimator.m
//  XWTADemo
//
//  Created by wazrx on 16/6/7.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWTransitionAnimator.h"
#import <objc/runtime.h>
#import <objc/message.h>

#pragma mark - 私有转场动画管理者

typedef void(^XWTransitionAnimationConfig)(id<UIViewControllerContextTransitioning> transitionContext);

@interface _XWTransitionObject : NSObject<UIViewControllerAnimatedTransitioning>


- (instancetype)_initObjectWithDuration:(NSTimeInterval)duration animationBlock:(void(^)(id<UIViewControllerContextTransitioning> transitionContext)) config;

@end

@implementation _XWTransitionObject{
    NSTimeInterval _duration;
    XWTransitionAnimationConfig _config;
}

- (instancetype)_initObjectWithDuration:(NSTimeInterval)duration animationBlock:(XWTransitionAnimationConfig)config{
    self = [super init];
    if (self) {
        _duration = duration;
        _config = config;
    }
    return self;
}

#pragma mark - <UIViewControllerAnimatedTransitioning>

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (_config) {
        _config(transitionContext);
    }
    
}

@end

@interface XWTransitionAnimator ()
@property (nonatomic, strong) _XWTransitionObject *toTransition;
@property (nonatomic, strong) _XWTransitionObject *backTranstion;
@property (nonatomic, strong) XWInteractiveTransition *toInteractive;
@property (nonatomic, strong) XWInteractiveTransition *backInteractive;
@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, assign) BOOL toType;

@end

@implementation XWTransitionAnimator


- (instancetype)init
{
    self = [super init];
    if (self) {
        _toDuration = _backDuration = 0.5f;
    }
    return self;
}

- (_XWTransitionObject *)toTransition{
    if (!_toTransition) {
        __weak typeof(self)weakSelf = self;
        _toTransition = [[_XWTransitionObject alloc] _initObjectWithDuration:_toDuration animationBlock:^(id<UIViewControllerContextTransitioning> transitionContext) {
            [weakSelf xw_setToAnimation:transitionContext];
        }];
    }
    return _toTransition;
}

- (_XWTransitionObject *)backTranstion{
    if (!_backTranstion) {
        __weak typeof(self)weakSelf = self;
        _backTranstion = [[_XWTransitionObject alloc] _initObjectWithDuration:_backDuration animationBlock:^(id<UIViewControllerContextTransitioning> transitionContext) {
            [weakSelf xw_setBackAnimation:transitionContext];
        }];
    }
    return _backTranstion;
}

- (void)setToInteractive:(XWInteractiveTransition *)toInteractive{
    _toInteractive = toInteractive;
    toInteractive.delegate = self;
    toInteractive.timerEable = _needInteractiveTimer;
    
}

- (void)setBackInteractive:(XWInteractiveTransition *)backInteractive{
    _backInteractive = backInteractive;
    backInteractive.delegate = self;
    backInteractive.timerEable = _needInteractiveTimer;
    
}

- (void)xw_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //交给子类实现
}

- (void)xw_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //交给子类实现
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.toTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.backTranstion;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.backInteractive.interation ? self.backInteractive : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.toInteractive.interation ? self.toInteractive : nil;
}

#pragma mark - <UINavigationControllerDelegate>

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _operation = operation;
    return operation == UINavigationControllerOperationPush ? self.toTransition : self.backTranstion;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    XWInteractiveTransition *inter = _operation == UINavigationControllerOperationPush ? self.toInteractive : self.backInteractive;
    return inter.interation ? inter : nil;
}

@end


