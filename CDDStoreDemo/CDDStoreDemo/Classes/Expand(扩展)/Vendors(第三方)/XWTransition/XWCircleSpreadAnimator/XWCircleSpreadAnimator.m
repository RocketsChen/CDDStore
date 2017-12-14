//
//  XWCircleSpreadAnimator.m
//  XWTADemo
//
//  Created by wazrx on 16/6/7.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCircleSpreadAnimator.h"

@interface XWCircleSpreadAnimator ()<CAAnimationDelegate>
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGFloat startRadius;
@property (nonatomic, strong) UIBezierPath *startPath;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation XWCircleSpreadAnimator

+ (instancetype)xw_animatorWithStartCenter:(CGPoint)point radius:(CGFloat)radius {
    return [[self alloc] _initWithStartCenter:point radius:radius];
}

- (instancetype)_initWithStartCenter:(CGPoint)point radius:(CGFloat)radius
{
    self = [super init];
    if (self) {
        _startPoint = point;
        _startRadius = radius == 0 ? 0.01 : radius;
        self.needInteractiveTimer = YES;
    }
    return self;
}

- (void)xw_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithArcCenter:self.startPoint radius:self.startRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CGFloat x = self.startPoint.x;
    CGFloat y = self.startPoint.y;
    CGFloat endX = MAX(x, containerView.frame.size.width - x);
    CGFloat endY = MAX(y, containerView.frame.size.height - y);
    CGFloat radius = sqrtf(pow(endX, 2) + pow(endY, 2));
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:self.startPoint radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    toVC.view.layer.mask = maskLayer;
    self.startPath = startCycle;
    self.maskLayer = maskLayer;
    self.containerView = containerView;
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = self.toDuration;
    maskLayerAnimation.delegate = self;
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"xw_path"];
}

- (void)xw_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view atIndex:0];
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:self.startPoint radius:self.startRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *maskLayer = (CAShapeLayer *)fromVC.view.layer.mask;
    CGPathRef startPath = maskLayer.path;
    maskLayer.path = endCycle.CGPath;
    self.maskLayer = maskLayer;
    self.startPath = [UIBezierPath bezierPathWithCGPath:startPath];
    self.containerView = containerView;
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startPath);
    maskLayerAnimation.toValue = (__bridge id)(endCycle.CGPath);
    maskLayerAnimation.duration = self.backDuration;
    maskLayerAnimation.delegate = self;
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"xw_path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}

- (void)xw_interactiveTransitionWillBeginTimerAnimation:(XWInteractiveTransition *)interactiveTransition{
    _containerView.userInteractionEnabled = NO;
}

- (void)xw_interactiveTransition:(XWInteractiveTransition *)interactiveTransition willEndWithSuccessFlag:(BOOL)flag percent:(CGFloat)percent{
    if (!flag) {
        //防止失败后的闪烁
        _maskLayer.path = _startPath.CGPath;
    }
    _containerView.userInteractionEnabled = YES;
}

@end
