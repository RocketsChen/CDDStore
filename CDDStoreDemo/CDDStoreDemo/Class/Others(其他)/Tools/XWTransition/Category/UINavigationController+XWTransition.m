//
//  UINavigationController+XWTransition.m
//  XWTADemo
//
//  Created by wazrx on 16/6/7.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UINavigationController+XWTransition.h"
#import "UIViewController+XWTransition.h"
#import "XWTransitionAnimator.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UINavigationController (XWTransition)

+ (void)load{
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(pushViewController:animated:)), class_getInstanceMethod([self class], @selector(_xw_pushViewController:animated:)));
}

- (void)xw_pushViewController:(UIViewController *)viewController withAnimator:(XWTransitionAnimator *)animator {
    if (!viewController) return;
    XWInteractiveTransition *toInteractive = objc_getAssociatedObject(self.topViewController, &kXWToInteractiveKey);
    if (toInteractive) {
        [animator setValue:toInteractive forKey:@"toInteractive"];
    }
    if (animator) {
        objc_setAssociatedObject(viewController, &kXWAnimatorKey, animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self pushViewController:viewController animated:YES];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self _xw_swizzeViewControlelrDealloc];
    });
}

- (void)_xw_swizzeViewControlelrDealloc{
    Class swizzleClass = [UIViewController class];
    @synchronized(swizzleClass) {
        SEL deallocSelector = sel_registerName("dealloc");
        __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
        __weak typeof(self)weakSelf = self;
        id newDealloc = ^(__unsafe_unretained UIViewController *objSelf){
            [weakSelf _xw_checkDelegate];
            if (originalDealloc == NULL) {
                struct objc_super superInfo = {
                    .receiver = objSelf,
                    .super_class = class_getSuperclass(swizzleClass)
                };
                void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                msgSend(&superInfo, deallocSelector);
            }else{
                originalDealloc(objSelf, deallocSelector);
            }
        };
        IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
        if (!class_addMethod(swizzleClass, deallocSelector, newDeallocIMP, "v@:")) {
            Method deallocMethod = class_getInstanceMethod(swizzleClass, deallocSelector);
            originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);
            originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
        }
    }
}

- (void)_xw_checkDelegate{
    XWTransitionAnimator *animator = objc_getAssociatedObject(self.topViewController, &kXWAnimatorKey);
    if (animator) {
        self.delegate = animator;
    }else{
        self.delegate = nil;
    }
}

- (void)_xw_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    XWTransitionAnimator *animator = objc_getAssociatedObject(viewController, &kXWAnimatorKey);
    if (animator) {
        self.delegate = animator;
    }else if([self.delegate isKindOfClass:[XWTransitionAnimator class]]){
        self.delegate = nil;
    }
    [self _xw_pushViewController:viewController animated:animated];
}

@end
