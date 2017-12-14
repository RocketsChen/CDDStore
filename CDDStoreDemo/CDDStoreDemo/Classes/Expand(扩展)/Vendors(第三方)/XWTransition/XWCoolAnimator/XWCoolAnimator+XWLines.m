//
//  XWCoolAnimator+XWVerticalLines.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCoolAnimator+XWLines.h"

@implementation XWCoolAnimator (XWLines)

static inline float XWRandomFloat(float max, float min){
    return ((float)arc4random() / 0x100000000) * (max - min) + min;
}

- (void)xw_setLinesToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext vertical:(BOOL)vertical {
    [self _xw_animateTransition:transitionContext duration:self.toDuration to:YES vertical:vertical];
    
}

- (void)xw_setLinesBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext vertical:(BOOL)vertical {
    [self _xw_animateTransition:transitionContext duration:self.toDuration to:NO vertical:vertical];
    
}


#define HLINEHEIGHT 4.0
- (void)_xw_animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration to:(BOOL)flag vertical:(BOOL)vertical{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toView atIndex:0];
    NSArray *outgoingLineViews = [self _xw_lineViews:fromVC.view intoSlicesOfDis:HLINEHEIGHT Offset:fromVC.view.frame.origin.y containerView:containerView vertical:vertical];
    NSArray *incomingLineViews = [self _xw_lineViews:toView intoSlicesOfDis:HLINEHEIGHT Offset:toView.frame.origin.y containerView:containerView vertical:vertical];
    CGFloat toViewStart = vertical ? toView.frame.origin.y : toView.frame.origin.x;
    BOOL presenting = flag;
    vertical ? [self _xw_repositionViewSlices:incomingLineViews moveFirstFrameUp:NO]:[self _xw_repositionViewSlices:incomingLineViews moveLeft:!presenting];
    fromVC.view.hidden = YES;
    toView.hidden = YES;
    [UIView animateWithDuration:duration - 0.01 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        vertical ? [self _xw_repositionViewSlices:outgoingLineViews moveFirstFrameUp:YES] : [self _xw_repositionViewSlices:outgoingLineViews moveLeft:presenting];
        [self _xw_resetViewSlices:incomingLineViews toOrigin:toViewStart vertical:vertical];
    } completion:^(BOOL finished) {
        fromVC.view.hidden = NO;
        toView.hidden = NO;
        [toView setNeedsUpdateConstraints];
        for (UIView *v in incomingLineViews) {
            [v removeFromSuperview];
        }
        for (UIView *v in outgoingLineViews) {
            [v removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (UIImage *)_xw_ImageFromsnapshotView:(UIView *)view{
    CALayer *layer = view.layer;
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//弃用了原作者的截取若干小图的方法，由于toView刚开始无法截图，原作者采用延迟0.001秒后来截图，但是这种方式不是对手势和转场失败的效果有很大的干扰，所以我转换思路换了一种方式实现了小图，采用的是contentsRect
- (NSArray<UIView *> *)_xw_lineViews:(UIView *)view intoSlicesOfDis:(float)dis Offset:(float)yOffset containerView:(UIView *)containerView vertical:(BOOL)vertical{
    CGFloat width = vertical ? CGRectGetHeight(view.frame) : CGRectGetWidth(view.frame);
    CGFloat height = !vertical ? CGRectGetHeight(view.frame) : CGRectGetWidth(view.frame);
    UIImage *img = [self _xw_ImageFromsnapshotView:view];
    NSMutableArray *lineViews = [NSMutableArray array];
    for (int i = 0; i < height; i += dis) {
        CGRect subrect = vertical ? CGRectMake(i, 0, dis, width) : CGRectMake(0, i, width, dis);
        UIView *subsnapshot = [UIView new];
        subsnapshot.layer.contents= (__bridge id)img.CGImage;
        subsnapshot.layer.contentsRect = vertical ? CGRectMake((float)i / view.frame.size.width, 0.0,  dis / view.frame.size.width, 1.0) : CGRectMake(0, (float)i / view.frame.size.height, 1.0, dis / view.frame.size.height);
        subrect.origin.x += yOffset;
        subsnapshot.frame = subrect;
        [lineViews addObject:subsnapshot];
        [containerView addSubview:subsnapshot];
    }
    return lineViews;
}


-(void)_xw_repositionViewSlices:(NSArray *)views moveLeft:(BOOL)left{
    CGRect frame;
    float width;
    for (UIView *line in views) {
        frame = line.frame;
        width = CGRectGetWidth(frame) * XWRandomFloat(1.0, 8.0);
        frame.origin.x += (left)?-width:width;
        line.frame = frame;
    }
}

-(void)_xw_repositionViewSlices:(NSArray *)views moveFirstFrameUp:(BOOL)startUp{
    
    BOOL up = startUp;
    CGRect frame;
    float height;
    for (UIView *line in views) {
        frame = line.frame;
        height = CGRectGetHeight(frame) * XWRandomFloat(1.0, 4.0);
        frame.origin.y += (up)?-height:height;
        line.frame = frame;
        
        up = !up;
    }
}

-(void)_xw_resetViewSlices:(NSArray *)views toOrigin:(CGFloat)o vertical:(BOOL)vertical{
    CGRect frame;
    for (UIView *line in views) {
        frame = line.frame;
        if (vertical) {
            frame.origin.y = o;
        }else{
            frame.origin.x = o;
        }
        line.frame = frame;
    }
}

@end
