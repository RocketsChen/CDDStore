//
//  XWCoolAnimator+XWMiddlePageFlip.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCoolAnimator.h"

typedef NS_ENUM(NSUInteger, XWMiddlePageFlipDirection) {
    XWMiddlePageFlipDirectionLeft,
    XWMiddlePageFlipDirectionRight,
    XWMiddlePageFlipDirectionTop,
    XWMiddlePageFlipDirectionBottom
};

@interface XWCoolAnimator (XWMiddlePageFlip)


- (void)xw_setMiddlePageFlipToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext direction:(XWMiddlePageFlipDirection)direction;

- (void)xw_setMiddlePageFlipBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext direction:(XWMiddlePageFlipDirection)direction;
@end
