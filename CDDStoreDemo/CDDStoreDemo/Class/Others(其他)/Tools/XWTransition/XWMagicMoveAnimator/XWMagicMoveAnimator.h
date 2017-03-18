//
//  XWMagicMoveAnimator.h
//  XWTADemo
//
//  Created by wazrx on 16/6/8.
//  Copyright © 2016年 wazrx. All rights reserved.
//  神奇移动效果请配合UIViewController+XWTransition中的相关API使用，如果神奇移动的终止视图为cell，需要参考一下demo中的九宫格例子

#import "XWTransitionAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XWTransition)

//神奇移动的时候，如果对设置view的该属性为YES，则移动视图不会按照截图的方式生成，而且尝试直接取得其image（暂时支持imageView、button等），解决神奇移动从下到大会产生模糊的情况
@property (nonatomic, assign) BOOL magicMoveImageMode;

@end


@interface XWMagicMoveAnimator : XWTransitionAnimator

//是否开启弹簧效果
@property (nonatomic, assign) BOOL dampingEnable;
//设为YES后，对于做神奇移动数组中的所有View会直接取其图片而不会截图，可解决神奇移动从小变得较大的时候，截图不清晰的问题，如果想要对单个view最该设置，请参考上面的UIView分类的magicMoveImageMode属性
@property (nonatomic, assign) BOOL imageMode;

@end

UIKIT_EXTERN NSString *const kXWMagicMoveAnimatorStartViewVCKey;
UIKIT_EXTERN NSString *const kXWMagicMoveAnimatorEndViewVCKey;

NS_ASSUME_NONNULL_END