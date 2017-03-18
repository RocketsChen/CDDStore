//
//  UIViewController+XWTransition.m
//  XWTADemo
//
//  Created by wazrx on 16/6/7.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UIViewController+XWTransition.h"
#import "XWMagicMoveAnimator.h"
#import <objc/runtime.h>

@implementation UIViewController (XWTransition)

- (void)xw_registerToInteractiveTransitionWithDirection:(XWInteractiveTransitionGestureDirection)direction transitonBlock:(void(^)(CGPoint startPoint))tansitionConfig edgeSpacing:(CGFloat)edgeSpacing{
    if (!tansitionConfig) return;
    XWInteractiveTransition *interactive = [XWInteractiveTransition xw_interactiveTransitionWithDirection:direction config:tansitionConfig edgeSpacing:edgeSpacing];
    [interactive xw_addPanGestureForView:self.view to:YES];
    objc_setAssociatedObject(self, &kXWToInteractiveKey, interactive, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)xw_registerBackInteractiveTransitionWithDirection:(XWInteractiveTransitionGestureDirection)direction transitonBlock:(void(^)(CGPoint startPoint))tansitionConfig edgeSpacing:(CGFloat)edgeSpacing{
    if (!tansitionConfig) return;
    XWInteractiveTransition *interactive = [XWInteractiveTransition xw_interactiveTransitionWithDirection:direction config:tansitionConfig edgeSpacing:edgeSpacing];
    [interactive xw_addPanGestureForView:self.view to:NO];
    XWTransitionAnimator *animator = objc_getAssociatedObject(self, &kXWAnimatorKey);if (animator) {
        [animator setValue:interactive forKey:@"backInteractive"];
    }
}

- (void)xw_presentViewController:(UIViewController *)viewController withAnimator:(XWTransitionAnimator *)animator {
    if (!viewController) return;
    if (!animator) animator = [XWTransitionAnimator new];
    viewController.transitioningDelegate = animator;
    XWInteractiveTransition *toInteractive = objc_getAssociatedObject(self, &kXWToInteractiveKey);
    if (toInteractive) {
        [animator setValue:toInteractive forKey:@"toInteractive"];
    }
    objc_setAssociatedObject(viewController, &kXWAnimatorKey, animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)xw_addMagicMoveStartViewGroup:(NSArray<UIView *> *)group {
    if (!group.count) return;
    objc_setAssociatedObject(self, &kXWMagicMoveAnimatorStartViewVCKey, group, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xw_addMagicMoveEndViewGroup:(NSArray<UIView *> *)group {
    if (!group.count) return;
    objc_setAssociatedObject(self, &kXWMagicMoveAnimatorEndViewVCKey, group, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
}

- (void)xw_changeMagicMoveStartViewGroup:(NSArray<UIView *> *)group {
    [self xw_addMagicMoveStartViewGroup:group];
}

@end

NSString *const kXWToInteractiveKey = @"kXWToInteractiveKey";
NSString *const kXWAnimatorKey = @"kXWAnimatorKey";
