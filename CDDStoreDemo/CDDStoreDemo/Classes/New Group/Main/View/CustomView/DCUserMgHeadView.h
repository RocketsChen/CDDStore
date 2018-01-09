//
//  DCUserMgHeadView.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/18.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCUserMgHeadView : UIView

/** 头部点击回调 */
@property (nonatomic, copy) dispatch_block_t headButtonClickBlock;

/** 头部View点击回调 */
@property (nonatomic, copy) dispatch_block_t headViewTouchBlock;

/** 二维码点击回调 */
@property (nonatomic, copy) dispatch_block_t erCodeClickBlock;

/** 我的主页点击回调 */
@property (nonatomic, copy) dispatch_block_t myHomeClickBlock;

@end
