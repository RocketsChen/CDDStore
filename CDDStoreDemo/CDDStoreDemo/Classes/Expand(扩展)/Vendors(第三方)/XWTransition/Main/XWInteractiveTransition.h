//
//  XWInteractiveTransition.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/10.
//  Copyright © 2016年 wazrx. All rights reserved.
//  手势转场管理者
//  注意：使用UIViewController+XWTransition相关API配合animator，通常情况下无需自己创建手势过渡管理者

#import <UIKit/UIKit.h>
@class XWInteractiveTransition;

NS_ASSUME_NONNULL_BEGIN

/**手势转场时的代理事件，animator默认为为其手势的代理，复写对应的代理事件可处理一些手势失败闪烁的情况*/
@protocol XWInteractiveTransitionDelegate <NSObject>

@optional
/**手势转场即将开始时调用*/
- (void)xw_interactiveTransitionWillBegin:(XWInteractiveTransition *)interactiveTransition;
/**手势转场中调用*/
- (void)xw_interactiveTransition:(XWInteractiveTransition *)interactiveTransition isUpdating:(CGFloat)percent;
/**如果开始了转场手势timer，会在松开手指，timer开始的时候调用*/
- (void)xw_interactiveTransitionWillBeginTimerAnimation:(XWInteractiveTransition *)interactiveTransition;
/**手势转场结束的时候调用*/
- (void)xw_interactiveTransition:(XWInteractiveTransition *)interactiveTransition willEndWithSuccessFlag:(BOOL)flag percent:(CGFloat)percent;

@end

/**手势转场方向*/
typedef NS_ENUM(NSUInteger, XWInteractiveTransitionGestureDirection) {
    XWInteractiveTransitionGestureDirectionLeft = 0,
    XWInteractiveTransitionGestureDirectionRight,
    XWInteractiveTransitionGestureDirectionUp,
    XWInteractiveTransitionGestureDirectionDown
};

@interface XWInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign, readonly) BOOL interation;
@property (nonatomic, assign) BOOL timerEable;
@property (nonatomic, weak) id<XWInteractiveTransitionDelegate> delegate;

/**设置该值可改变计算手势百分比的基准，手势基准的原理：百分比 = 拖动距离 / panRatioBaseValue， 默认情况下水平方向panRatioBaseValue为手势所在view的宽度，垂直方向为手势所在view的高度，通常无需更改该值，在某些特殊情况下，如果想要调整手势的速率可以更改该值，比如让手势速率加倍，可以调整该值为view宽度高度的一半*/
@property (nonatomic, assign) CGFloat panRatioBaseValue;

+ (instancetype)xw_interactiveTransitionWithDirection:(XWInteractiveTransitionGestureDirection)direction config:(void(^)(CGPoint startPoint))config edgeSpacing:(CGFloat)edgeSpacing;

- (void)xw_addPanGestureForView:(UIView *)view to:(BOOL)flag;

@end

NS_ASSUME_NONNULL_END