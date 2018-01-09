//
//  DCMyCenterHeaderView.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/12.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCMyCenterHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *myIconButton;

/* 头像点击回调 */
@property (nonatomic, copy) dispatch_block_t headClickBlock;
/** 二维码点击回调 */
@property (nonatomic, copy) dispatch_block_t qrClickBlock;
/** 我的朋友点击回调 */
@property (nonatomic, copy) dispatch_block_t myFriendClickBlock;
/** 朋友圈点击回调 */
@property (nonatomic, copy) dispatch_block_t friendCircleClickBlock;

/** 查看会员点击 */
@property (nonatomic, copy) dispatch_block_t seePriceClickBlock;

@end
