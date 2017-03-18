//
//  XWFilterAnimator.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/17.
//  Copyright © 2016年 wazrx. All rights reserved.
// XWFilterAnimator 全都是基于不同的CIFilter产生的一些滤镜效果，貌似在模拟器无法运行这些效果，请在真机上测试

#import "XWTransitionAnimator.h"
#import "XWFilterTransitionView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XWFilterAnimatorType) {
    XWFilterAnimatorTypeBoxBlur,//模糊转场,对应CIBoxBlur
    XWFilterAnimatorTypeSwipe,//滑动过渡转场，对应CISwipeTranstion
    XWFilterAnimatorTypeBarSwipe,//对应CIBarSwipeTranstion
    XWFilterAnimatorTypeMask,//按指定遮罩图片转场，对应CIDisintegrateWithMaskTransition
    XWFilterAnimatorTypeFlash,//闪烁转场，对应CIFlashTransition
    XWFilterAnimatorTypeMod,//条纹转场 对应CIModTransition
    XWFilterAnimatorTypePageCurl,//翻页转场 对应CIPageCurlWithShadowTransition
    XWFilterAnimatorTypeRipple,//波纹转场，对应CIRippleTransition
    XWFilterAnimatorTypeCopyMachine, //效果和XWCoolAnimator中的Scanning效果类似，对应CICopyMachineTransition
};

@interface XWFilterAnimator : XWTransitionAnimator

/**for XWFilterAnimatorTypeMask，如果为空，则为默认的maskImg*/
@property (nonatomic, strong) UIImage *maskImg;
/**是否翻转，对于有转场有方向之分的此属性可用，如果为YES，如果to转场为左，那么back转场为右，默认为YES*/
@property (nonatomic, assign) BOOL revers;
/**开始角度，对于有转场方向的转场此属性可用，0为左，M_PI_2 为下 M_PI 为右 M_PI_2 * 3为上，也可指定任意开始角度*/
@property (nonatomic, assign) CGFloat startAngle;

/**
 *  初始化一个filter转场效果器
 *
 *  @param type 效果枚举值
 *
 *  @return 效果器
 */
+ (instancetype)xw_animatorWithType:(XWFilterAnimatorType)type;

@end

NS_ASSUME_NONNULL_END