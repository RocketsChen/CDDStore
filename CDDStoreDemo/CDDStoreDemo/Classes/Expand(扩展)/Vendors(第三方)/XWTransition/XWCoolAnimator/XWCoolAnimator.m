//
//  XWCoolAnimator.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCoolAnimator.h"
#import "XWCoolAnimator+XWPortal.h"
#import "XWCoolAnimator+XWPageFlip.h"
#import "XWCoolAnimator+XWFold.h"
#import "XWCoolAnimator+XWMiddlePageFlip.h"
#import "XWCoolAnimator+XWExplode.h"
#import "XWCoolAnimator+XWLines.h"
#import "XWCoolAnimator+XWScanning.h"

@interface XWCoolAnimator ()
@property (nonatomic, weak) UIView *pageFlipTempView;
@end

@implementation XWCoolAnimator{
    XWCoolTransitionAnimatorType _type;
}

- (void)dealloc{
    NSLog(@"coolAnimator销毁了");
}


+ (instancetype)xw_animatorWithType:(XWCoolTransitionAnimatorType)type {
    return [[self alloc] _initWithTransitionType:type];
}

- (instancetype)_initWithTransitionType:(XWCoolTransitionAnimatorType)type{
    self = [super init];
    if (self) {
        _type = type;
        _foldCount = 4;
    }
    return self;
}



- (void)xw_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case XWCoolTransitionAnimatorTypePageFlip: {
            [self xw_setPageFlipToAnimation:transitionContext];
            break;
        }
        case XWCoolTransitionAnimatorTypePageMiddleFlipFromLeft: {
            [self xw_setMiddlePageFlipToAnimation:transitionContext direction:XWMiddlePageFlipDirectionLeft];
            break;
        }
        case XWCoolTransitionAnimatorTypePageMiddleFlipFromRight: {
            [self xw_setMiddlePageFlipToAnimation:transitionContext direction:XWMiddlePageFlipDirectionRight];
            break;
        }
        case XWCoolTransitionAnimatorTypePageMiddleFlipFromTop: {
            [self xw_setMiddlePageFlipToAnimation:transitionContext direction:XWMiddlePageFlipDirectionTop];
            break;
        }
        case XWCoolTransitionAnimatorTypePageMiddleFlipFromBottom: {
            [self xw_setMiddlePageFlipToAnimation:transitionContext direction:XWMiddlePageFlipDirectionBottom];
            break;
        }
        case XWCoolTransitionAnimatorTypePortal: {
            [self xw_setPortalToAnimation:transitionContext];
            break;
        }
        case XWCoolTransitionAnimatorTypeFoldFromLeft: {
            [self xw_setFoldToAnimation:transitionContext leftFlag:YES];
            break;
        }
        case XWCoolTransitionAnimatorTypeFoldFromRight: {
            [self xw_setFoldToAnimation:transitionContext leftFlag:NO];
            break;
        }
        case XWCoolTransitionAnimatorTypeExplode: {
            [self xw_setExplodeToAnimation:transitionContext];
            break;
        }
        case XWCoolTransitionAnimatorTypeHorizontalLines: {
            [self xw_setLinesToAnimation:transitionContext vertical:NO];
            break;
        }
        case XWCoolTransitionAnimatorTypeVerticalLines: {
            [self xw_setLinesToAnimation:transitionContext vertical:YES];
            break;
        }
        case XWCoolTransitionAnimatorTypeScanningFromLeft: {
            [self xw_setScanningToAnimation:transitionContext direction:0];
            break;
        }
        case XWCoolTransitionAnimatorTypeScanningFromRight: {
            [self xw_setScanningToAnimation:transitionContext direction:1];
            break;
        }
        case XWCoolTransitionAnimatorTypeScanningFromTop: {
            [self xw_setScanningToAnimation:transitionContext direction:2];
            break;
        }
        case XWCoolTransitionAnimatorTypeScanningFromBottom: {
            [self xw_setScanningToAnimation:transitionContext direction:3];
            break;
        }
    }
}

- (void)xw_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case XWCoolTransitionAnimatorTypePageFlip: {
            [self xw_setPageFlipBackAnimation:transitionContext];
            break;
        }
        case XWCoolTransitionAnimatorTypePageMiddleFlipFromLeft: {
            [self xw_setMiddlePageFlipBackAnimation:transitionContext direction:XWMiddlePageFlipDirectionRight];
            break;
        }
        case XWCoolTransitionAnimatorTypePageMiddleFlipFromRight: {
            [self xw_setMiddlePageFlipBackAnimation:transitionContext direction:XWMiddlePageFlipDirectionLeft];
            break;
        }
        case XWCoolTransitionAnimatorTypePageMiddleFlipFromTop: {
            [self xw_setMiddlePageFlipBackAnimation:transitionContext direction:XWMiddlePageFlipDirectionBottom];
            break;
        }
        case XWCoolTransitionAnimatorTypePageMiddleFlipFromBottom: {
            [self xw_setMiddlePageFlipBackAnimation:transitionContext direction:XWMiddlePageFlipDirectionTop];
            break;
        }
        case XWCoolTransitionAnimatorTypePortal: {
            [self xw_setPortalBackAnimation:transitionContext];
            break;
        }
        case XWCoolTransitionAnimatorTypeFoldFromLeft: {
            [self xw_setFoldBackAnimation:transitionContext leftFlag:NO];
            break;
        }
        case XWCoolTransitionAnimatorTypeFoldFromRight: {
            [self xw_setFoldBackAnimation:transitionContext leftFlag:YES];
            break;
        }
        case XWCoolTransitionAnimatorTypeExplode: {
            [self xw_setExplodeBackAnimation:transitionContext];
            break;
        }
        case XWCoolTransitionAnimatorTypeHorizontalLines: {
            [self xw_setLinesBackAnimation:transitionContext vertical:NO];
            break;
        }
        case XWCoolTransitionAnimatorTypeVerticalLines: {
            [self xw_setLinesBackAnimation:transitionContext vertical:YES];
            break;
        }
        case XWCoolTransitionAnimatorTypeScanningFromLeft: {
            [self xw_setScanningBackAnimation:transitionContext direction:1];
            break;
        }
        case XWCoolTransitionAnimatorTypeScanningFromRight: {
            [self xw_setScanningBackAnimation:transitionContext direction:0];
            break;
        }
        case XWCoolTransitionAnimatorTypeScanningFromTop: {
            [self xw_setScanningBackAnimation:transitionContext direction:3];
            break;
        }
        case XWCoolTransitionAnimatorTypeScanningFromBottom: {
            [self xw_setScanningBackAnimation:transitionContext direction:2];
            break;
        }
    }
}





@end
