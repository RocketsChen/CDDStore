//
//  XWCoolAnimator.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWTransitionAnimator.h"

/**
 cool转场效果中的Portal、Fold、Explode效果的部分代码逻辑来源于ColinEberhardt/VCTransitionsLibrary，地址:https://github.com/ColinEberhardt/VCTransitionsLibrary 非常感谢作者，我只是将其进行了部分改动，以便对手势的支持更加完善，里面还有许多其他效果，本人经历有限就没有再集成进来了，大家可以自行查看；
 cool转场效果的Lines的想法来自于cinkster/HUAnimator，地址：https://github.com/cinkster/HUAnimator， 非常感谢作者，但是由于作者在对toVC截图采用了延迟的方式来处理，导致了闪烁和一些手势上的bug，对此我采用了另一种方式来解决截图的问题，使用了layer的contentRect属性，解决了闪烁问题和延迟截图的bug问题，相关代码请自行查看
 
 */

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XWCoolTransitionAnimatorType){
    //全屏翻页
    XWCoolTransitionAnimatorTypePageFlip,
    //中间翻页
    XWCoolTransitionAnimatorTypePageMiddleFlipFromLeft,
    XWCoolTransitionAnimatorTypePageMiddleFlipFromRight,
    XWCoolTransitionAnimatorTypePageMiddleFlipFromTop,
    XWCoolTransitionAnimatorTypePageMiddleFlipFromBottom,
    //开窗
    XWCoolTransitionAnimatorTypePortal,
    //折叠
    XWCoolTransitionAnimatorTypeFoldFromLeft,
    XWCoolTransitionAnimatorTypeFoldFromRight,
    //爆炸
    XWCoolTransitionAnimatorTypeExplode,
    //酷炫线条效果
    XWCoolTransitionAnimatorTypeHorizontalLines,
    XWCoolTransitionAnimatorTypeVerticalLines,
    //扫描效果
    XWCoolTransitionAnimatorTypeScanningFromLeft,
    XWCoolTransitionAnimatorTypeScanningFromRight,
    XWCoolTransitionAnimatorTypeScanningFromTop,
    XWCoolTransitionAnimatorTypeScanningFromBottom,
    
    
};

@interface XWCoolAnimator : XWTransitionAnimator

//flod效果的折叠数量， for XWCoolTransitionAnimatorTypeFoldFromLeft 和 XWCoolTransitionAnimatorTypeFoldFromRight
@property (nonatomic) NSUInteger foldCount;

+ (instancetype)xw_animatorWithType:(XWCoolTransitionAnimatorType)type;

@end

NS_ASSUME_NONNULL_END