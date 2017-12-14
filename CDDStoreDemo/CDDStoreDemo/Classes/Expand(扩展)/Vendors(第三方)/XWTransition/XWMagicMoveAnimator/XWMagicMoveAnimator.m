//
//  XWMagicMoveAnimator.m
//  XWTADemo
//
//  Created by wazrx on 16/6/8.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWMagicMoveAnimator.h"
#import <objc/runtime.h>

static NSString *const kXWMagicMovePropertyInViewKey = @"kXWMagicMovePropertyInViewKey";

@implementation UIView (XWTransition)

- (void)setMagicMoveImageMode:(BOOL)magicMoveImageMode{
    objc_setAssociatedObject(self, &kXWMagicMovePropertyInViewKey, @(magicMoveImageMode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)magicMoveImageMode{
    return [objc_getAssociatedObject(self, &kXWMagicMovePropertyInViewKey) boolValue];
}


@end

@implementation XWMagicMoveAnimator

- (void)xw_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self _xw_doAniamtionWithContext:transitionContext fromFlag:YES];
    
}

- (void)xw_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self _xw_doAniamtionWithContext:transitionContext fromFlag:NO];
    
}

-(void)_xw_doAniamtionWithContext:(id<UIViewControllerContextTransitioning>)transitionContext fromFlag:(BOOL)flag{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *realFromVC = [self _xw_getRealContainsGroupViewController:fromVC];
    UIViewController *realToVC = [self _xw_getRealContainsGroupViewController:toVC];
    NSArray<UIView *> *startViewGroup = objc_getAssociatedObject(realFromVC, flag ? &kXWMagicMoveAnimatorStartViewVCKey : &kXWMagicMoveAnimatorEndViewVCKey);
    NSArray<UIView *> *endViewGroup = objc_getAssociatedObject(realToVC, !flag ? &kXWMagicMoveAnimatorStartViewVCKey : &kXWMagicMoveAnimatorEndViewVCKey);
    if (!startViewGroup.count || !endViewGroup.count || startViewGroup.count != endViewGroup.count) {
        NSLog(@"神奇移动的视图为空，或者移动前后视图不相等");
        [transitionContext completeTransition:NO];
        return;
    }
    UIView *containerView = [transitionContext containerView];
    toVC.view.alpha = 0.0f;
    [containerView addSubview:toVC.view];
    NSArray *toRects = [self _xw_getFrameValueFromViewGroup:endViewGroup inContainerView:containerView];
    NSArray<UIView *> *tempViewGroup = [self _xw_makeTempViewGroupWithViewGroup:startViewGroup inContainerView:containerView];
    [self _xw_changeHiddenViewInGroup:startViewGroup hidden:YES];
    [self _xw_changeHiddenViewInGroup:endViewGroup hidden:YES];
    if (self.dampingEnable) {
        [UIView animateWithDuration:flag ? self.toDuration : self.backDuration delay:0.0f usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:UIViewAnimationOptionCurveLinear animations:^{
            fromVC.view.alpha = 0.0f;
            toVC.view.alpha = 1.0f;
            [tempViewGroup enumerateObjectsUsingBlock:^(UIView *tempSubView, NSUInteger idx, BOOL * _Nonnull stop) {
                CGRect toRect = [toRects[idx] CGRectValue];
                tempSubView.frame = toRect;
            }];
            
        } completion:^(BOOL finished) {
            [tempViewGroup makeObjectsPerformSelector:@selector(removeFromSuperview)];
            fromVC.view.alpha = 1.0f;
            [self _xw_changeHiddenViewInGroup:startViewGroup hidden:NO];
            [self _xw_changeHiddenViewInGroup:endViewGroup hidden:NO];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }else{
        [UIView animateWithDuration:flag ? self.toDuration : self.backDuration animations:^{
            fromVC.view.alpha = 0.0f;
            toVC.view.alpha = 1.0f;
            [tempViewGroup enumerateObjectsUsingBlock:^(UIView *tempSubView, NSUInteger idx, BOOL * _Nonnull stop) {
                CGRect toRect = [toRects[idx] CGRectValue];
                tempSubView.frame = toRect;
            }];
        } completion:^(BOOL finished) {
            [tempViewGroup makeObjectsPerformSelector:@selector(removeFromSuperview)];
            fromVC.view.alpha = 1.0f;
            [self _xw_changeHiddenViewInGroup:startViewGroup hidden:NO];
            [self _xw_changeHiddenViewInGroup:endViewGroup hidden:NO];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

/**
 *  判断当前控制器的类型，从而找到从出存有移动视图组的控制器
 */
- (UIViewController *)_xw_getRealContainsGroupViewController:(UIViewController *)controller{
    UIViewController *realVC = controller;
    if ([controller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)realVC;
        if ([tabBarVC.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navVC = (UINavigationController *)tabBarVC.selectedViewController;
            realVC = navVC.topViewController;
        }else{
            realVC = tabBarVC.selectedViewController;
        }
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navVC = (UINavigationController *)controller;
        realVC = navVC.topViewController;
    }
    return realVC;
}


- (NSArray *)_xw_getFrameValueFromViewGroup:(NSArray<UIView *> *)group inContainerView:(UIView *)containerView{
    NSMutableArray *temp = @[].mutableCopy;
    [group enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = [view convertRect:view.bounds toView:containerView];
        [temp addObject:[NSValue valueWithCGRect:rect]];
    }];
    return temp.copy;
}

- (NSArray<UIView *> *)_xw_makeTempViewGroupWithViewGroup:(NSArray<UIView *> *)group inContainerView:(UIView *)containerView{
    NSMutableArray *temp = @[].mutableCopy;
    [group enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *tempView = [self _xw_snapshotView:view];
        tempView.frame = [view convertRect:view.bounds toView:containerView];
        [containerView addSubview:tempView];
        [temp addObject:tempView];
    }];
    return temp.copy;
}

- (void)_xw_changeHiddenViewInGroup:(NSArray<UIView *> *)group hidden:(BOOL)flag{
    [group enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = flag;
    }];
}

- (UIView *)_xw_snapshotView:(UIView *)view{
    CALayer *layer = view.layer;
    UIView *snapView = [UIView new];
    snapView.frame = view.frame;
    BOOL imgMode = [objc_getAssociatedObject(view, &kXWMagicMovePropertyInViewKey) boolValue] || _imageMode;
    UIImage *img = nil;
    if (imgMode) {//如果开启imgMode，优先直接获取图片，避免截图时时从小到大造成的模糊
        if ([view isKindOfClass:[UIImageView class]]) {//取imageView中的image
            img = [(UIImageView *)view image];
        }else if ([view isKindOfClass:[UIButton class]]){//取button中的image
            img = [(UIButton *)view currentImage];
        }
        if (!img && [view isKindOfClass:[UIView class]]) {//没取到尝试取content
            img = [UIImage imageWithCGImage:(__bridge CGImageRef)view.layer.contents];
        }
    }
    //若都没有取到，则截图
    if (!img) {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.opaque, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [layer renderInContext:context];
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    snapView.layer.contents = (__bridge id)img.CGImage;
    return snapView;
}


@end

NSString *const kXWMagicMoveAnimatorStartViewVCKey = @"kXWMagicMoveAnimatorStartViewVCKey";
NSString *const kXWMagicMoveAnimatorEndViewVCKey = @"kXWMagicMoveAnimatorEndViewVCKey";
