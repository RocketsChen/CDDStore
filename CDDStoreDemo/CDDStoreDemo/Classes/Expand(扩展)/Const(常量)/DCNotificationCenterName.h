//
//  DCNotificationCenterName.h
//  CDDStoreDemo
//
//  Created by dashen on 2017/12/6.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCNotificationCenterName : NSObject

#pragma mark - 项目中所有通知

/** 登录成功选择控制器通知 */
UIKIT_EXTERN NSString *const LOGINSELECTCENTERINDEX;
/** 退出登录成功选择控制器通知 */
UIKIT_EXTERN NSString *const LOGINOFFSELECTCENTERINDEX;

/** 添加购物车或者立即购买通知 */
UIKIT_EXTERN NSString *const SELECTCARTORBUY;


/** 滚动到商品详情界面通知 */
UIKIT_EXTERN NSString *const SCROLLTODETAILSPAGE;
/** 滚动到商品评论界面通知 */
UIKIT_EXTERN NSString *const SCROLLTOCOMMENTSPAGE;

/** 展现顶部自定义工具条View通知 */
UIKIT_EXTERN NSString *const SHOWTOPTOOLVIEW;
/** 隐藏顶部自定义工具条View通知 */
UIKIT_EXTERN NSString *const HIDETOPTOOLVIEW;


/** 商品属性选择返回通知 */
UIKIT_EXTERN NSString *const SHOPITEMSELECTBACK;

/** 分享弹出通知 */
UIKIT_EXTERN NSString *const SHAREALTERVIEW;

/** 美信消息Item改变通知 */
UIKIT_EXTERN NSString *const DCMESSAGECOUNTCHANGE;

@end

