//
//  XWDrawerAnimator.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/15.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWDrawerAnimator.h"
#import "XWInteractiveTransition.h"
#import "UIView+Snapshot.h"
#import <objc/runtime.h>

@interface XWDrawerAnimator ()
@property (nonatomic, assign) XWDrawerAnimatorDirection direction;
@property (nonatomic, assign) BOOL vertical;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, weak) UIView *toFromTempView;
@property (nonatomic, weak) UIView *gestureView;
@property (nonatomic, assign) CGFloat stepOneScale;
@property (nonatomic, assign) CGFloat stepTwoScale;
@property (nonatomic, copy) dispatch_block_t backConfig;

@end

@implementation XWDrawerAnimator


+ (instancetype)xw_animatorWithDirection:(XWDrawerAnimatorDirection)direction moveDistance:(CGFloat)distance {
    return [[self alloc] _initWithDirection:direction moveDistance:distance];
}

- (instancetype)_initWithDirection:(XWDrawerAnimatorDirection)direction moveDistance:(CGFloat)distance{
    self = [super init];
    if (self) {
        _direction = direction;
        _distance = distance;
        _stepOneScale = 0.95;
        _stepTwoScale = 0.8;
        _scaleRatio = 1.0;
        _flipEnable = NO;
        _parallaxEnable = NO;
        _vertical = direction == XWDrawerAnimatorDirectionBottom || direction == XWDrawerAnimatorDirectionTop;
    }
    return self;
}

- (void)xw_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *fromTempView = [UIView new];
    fromTempView.contentImage = fromVC.view.snapshotImage;
    _toFromTempView = fromTempView;
    fromTempView.frame = fromVC.view.frame;
    [containerView addSubview:fromTempView];
    CGFloat distance = [self _xw_moveMaxDistance:containerView];
    [self _xw_addFullGestureAndTapBackViewInContainerView:containerView toView:toVC.view distance:distance];
    CGFloat parallaxDistance = 0.0f;
    if (_parallaxEnable) {
        parallaxDistance = distance * 0.5;
        [containerView insertSubview:toVC.view belowSubview:fromTempView];
    }else{
        fromTempView.layer.zPosition = -1000;
        [containerView addSubview:toVC.view];
    }
    NSInteger symbol = _direction == XWDrawerAnimatorDirectionLeft || _direction == XWDrawerAnimatorDirectionTop ? -1 : 1;
    CGFloat toViewStartx = _vertical ? 0 : (containerView.frame.size.width - fabs(parallaxDistance)) * symbol;
    CGFloat toViewStartY = _vertical ? (containerView.frame.size.height - fabs(parallaxDistance)) * symbol : 0;
    toVC.view.frame = CGRectOffset(containerView.bounds,toViewStartx, toViewStartY);
    fromVC.view.hidden = YES;
    CGAffineTransform transform = _vertical ? CGAffineTransformMakeTranslation(0, -(distance - parallaxDistance)) : CGAffineTransformMakeTranslation(-(distance - parallaxDistance), 0);
    [UIView animateKeyframesWithDuration:self.toDuration delay:0.0 options:0 animations:^{
        if (_flipEnable) {
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.35 animations:^{
                fromTempView.layer.transform = [self _xw_stepOneTransform];
            }];
            [UIView addKeyframeWithRelativeStartTime:0.35 relativeDuration:0.65 animations:^{
                fromTempView.layer.transform = [self _xw_stepTwoTransformWithView:fromTempView];
            }];
        }else{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
                if (_parallaxEnable) {
                    fromTempView.transform = _vertical ? CGAffineTransformMakeTranslation(0, -distance) : CGAffineTransformMakeTranslation(-distance, 0);
                }
                fromTempView.transform = CGAffineTransformScale(fromTempView.transform, _scaleRatio, _scaleRatio);
            }];
        }
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
            toVC.view.transform = transform;
        }];
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [fromTempView removeFromSuperview];
            fromVC.view.hidden = NO;
        }else{
            fromVC.view.userInteractionEnabled = NO;
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

/**
 *  计算toView的起始point
 */
- (CGPoint)_xw_getStartPoint:(UIView *)containerView parallaxDistance:(CGFloat)parallaxDistance{
    NSInteger symbol = _direction == XWDrawerAnimatorDirectionLeft || _direction == XWDrawerAnimatorDirectionTop ? -1 : 1;
    switch (_direction) {
        case XWDrawerAnimatorDirectionLeft: {
            return CGPointMake((_distance - fabs(parallaxDistance)) *symbol, 0);
        }
        case XWDrawerAnimatorDirectionRight: {
            return CGPointMake((containerView.frame.size.width - fabs(parallaxDistance)) *symbol, 0);
        }
        case XWDrawerAnimatorDirectionTop: {
            return CGPointMake(0, (_distance - fabs(parallaxDistance)) *symbol);
        }
        case XWDrawerAnimatorDirectionBottom: {
            return CGPointMake(0, (containerView.frame.size.height - fabs(parallaxDistance)) *symbol);
        }
    }
}

- (void)xw_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateKeyframesWithDuration:self.backDuration delay:0.0 options:0 animations:^{
        if (_flipEnable) {
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.35 animations:^{
                _toFromTempView.layer.transform = [self _xw_stepOneTransform];
            }];
            [UIView addKeyframeWithRelativeStartTime:0.35 relativeDuration:0.65 animations:^{
                _toFromTempView.layer.transform = CATransform3DIdentity;
            }];
        }else{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
                _toFromTempView.transform = CGAffineTransformIdentity;
            }];
            
        }
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
            fromVC.view.transform = CGAffineTransformIdentity;
        }];
    } completion:^(BOOL finished) {
        if (![transitionContext transitionWasCancelled]) {
            toVC.view.userInteractionEnabled = YES;
            toVC.view.hidden = NO;
            [_toFromTempView removeFromSuperview];
            [_gestureView removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

- (void)setScaleRatio:(CGFloat)scaleRatio{
    _scaleRatio = scaleRatio;
    if (scaleRatio != 0) {
        _stepOneScale = fmin(1.0, scaleRatio + 0.15);
        _stepTwoScale = fmax(0.1, scaleRatio);
    }
}

- (void)setFlipEnable:(BOOL)flipEnable{
    _flipEnable = flipEnable;
    if (flipEnable) _parallaxEnable = NO;
}

- (void)setParallaxEnable:(BOOL)parallaxEnable{
    _parallaxEnable = parallaxEnable;
    if (parallaxEnable) _flipEnable = NO;
}

- (CGFloat)_xw_moveMaxDistance:(UIView *)containerView{
    CGFloat dis = 0.0f;
    switch (_direction) {
        case XWDrawerAnimatorDirectionLeft: {
            dis = _distance ? -_distance : -containerView.frame.size.width;
            break;
        }
        case XWDrawerAnimatorDirectionRight: {
            dis = _distance ? _distance : containerView.frame.size.width;
            break;
        }
        case XWDrawerAnimatorDirectionTop: {
            dis = _distance ? -_distance : -containerView.frame.size.height;
            break;
        }
        case XWDrawerAnimatorDirectionBottom: {
            dis = _distance ? _distance : containerView.frame.size.height;
            break;
        }
    }
    return dis;
}

/**
 *  添加全局手势和点击视图
 */
- (void)_xw_addFullGestureAndTapBackViewInContainerView:(UIView *)containerView toView:(UIView *)toView distance:(CGFloat)distance{
    CGFloat width = _vertical ? containerView.frame.size.width : containerView.frame.size.width - fabs(distance);
    CGFloat height = _vertical ? containerView.frame.size.height - fabs(distance) : containerView.frame.size.height;
    if (width == 0 || height == 0)return;
    if (!_backConfig) return;
    NSArray<UIGestureRecognizer *> *gestures = toView.gestureRecognizers;
    __block id target = nil;
    [gestures enumerateObjectsUsingBlock:^(UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *panType = objc_getAssociatedObject(obj, "xw_interactivePanKey");
        if ([panType isEqualToString:@"xw_interactiveBackPan"] && obj.delegate) {
            target = obj.delegate;
            *stop = YES;
        }
    }];
    CGFloat x = _vertical || _direction == XWDrawerAnimatorDirectionRight ? 0 : -distance;
    CGFloat y = !_vertical || _direction == XWDrawerAnimatorDirectionBottom ? 0 : -distance;
    UIControl *gestureView = [UIControl new];
    [gestureView addTarget:self action:@selector(_xw_backConfig) forControlEvents:UIControlEventTouchUpInside];
    gestureView.frame = CGRectMake(x, y, width, height);
    gestureView.backgroundColor = [UIColor clearColor];
    //第一种情况，toView已经添加了返回手势，我们直接拿到该手势的target和action
    if (target) {
        //给containerView添加全局手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"_xw_handleGesture:")];
        [containerView addGestureRecognizer:pan];
        
    }else{
        //第二种情况，toView没有添加手势，我们需要创建一个
        __weak typeof(self)weakSelf = self;
        XWInteractiveTransition *backTransition = [XWInteractiveTransition xw_interactiveTransitionWithDirection:(XWInteractiveTransitionGestureDirection)_direction config:^(CGPoint startPoint){
            weakSelf.backConfig();
        } edgeSpacing:0];
        backTransition.panRatioBaseValue = _vertical ? containerView.frame.size.height : containerView.frame.size.width;
        [backTransition xw_addPanGestureForView:gestureView to:NO];
//        [self xw_setBackInteractiveTransition:backTransition];
        [self setValue:backTransition forKey:@"backTransition"];
    }
    [containerView addSubview:gestureView];
}

- (UIView *)_xw_makeBackInteractiveGestureView:(NSArray<UIGestureRecognizer *> *)gestures{
    __block id target = nil;
    [gestures enumerateObjectsUsingBlock:^(UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *panType = objc_getAssociatedObject(obj, "xw_interactivePanKey");
        if ([panType isEqualToString:@"xw_interactiveBackPan"] && obj.delegate) {
            target = obj.delegate;
            *stop = YES;
        }
    }];
    UIControl *gestureView = nil;
    if (target) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"_xw_handleGesture:")];
        gestureView = [UIControl new];
        [gestureView addTarget:self action:@selector(_xw_backConfig) forControlEvents:UIControlEventTouchUpInside];
        gestureView.backgroundColor = [UIColor clearColor];
        [gestureView addGestureRecognizer:pan];
    }
    return gestureView;
}

- (void)_xw_backConfig{
    if (_backConfig) {
        _backConfig();
    }
}

-(CATransform3D)_xw_stepOneTransform{
    CGFloat rotationRatio = 1 + (0.95 - _stepOneScale) * 3.0f;
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0 / -900;
    t1 = CATransform3DScale(t1, _stepOneScale, _stepOneScale, 1);
    NSInteger symbol = _direction == XWDrawerAnimatorDirectionLeft || _direction == XWDrawerAnimatorDirectionBottom ? 1 : -1;
    t1 = CATransform3DRotate(t1, 15.0f * M_PI / 180.0f * rotationRatio * symbol, _vertical, !_vertical, 0);
    return t1;
    
}

-(CATransform3D)_xw_stepTwoTransformWithView:(UIView*)view{
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self _xw_stepOneTransform].m34;
    NSInteger symbol = _direction == XWDrawerAnimatorDirectionRight || _direction == XWDrawerAnimatorDirectionBottom ? -1 : 1;
    CGFloat x = _vertical ?  0: view.frame.size.width * 0.08 * symbol;
    CGFloat y = _vertical ?  view.frame.size.height * 0.08 * symbol: 0;
    t2 = CATransform3DTranslate(t2, x, y, 0);
    t2 = CATransform3DScale(t2, _stepTwoScale, _stepTwoScale, 1);
    
    return t2;
}

- (void)xw_enableEdgeGestureAndBackTapWithConfig:(dispatch_block_t)backConfig {
    _backConfig = backConfig;
	
}

@end
