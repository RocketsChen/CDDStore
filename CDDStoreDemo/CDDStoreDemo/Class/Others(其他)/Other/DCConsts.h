//
//  DCConsts.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface DCConsts : NSObject


/** 常量 */
UIKIT_EXTERN CGFloat const DCMargin;


/** 立即购买点击退出当前界面通知 */
UIKIT_EXTERN NSString * const DCBuyButtonDidDismissClickNotificationCenter;



/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

/** RGB */
#define DCRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/** 没有导航栏的屏幕高度 */
#define ScreenHNoNavi ([UIScreen mainScreen].bounds.size.height - 64 - 49)

/*****************  屏幕适配  ******************/
#define iphone6p (ScreenH == 763)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)


@end
