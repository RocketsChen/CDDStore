//
//  DCColonInsView.h
//  CDDMall
//
//  Created by apple on 2017/6/15.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCColonInsView : UIView

#pragma mark - 初始化
- (void)setUpUI;

/** 收藏回调 */
@property (nonatomic, copy) dispatch_block_t collectionBlock;
/** 加入购物车回调 */
@property (nonatomic, copy) dispatch_block_t addShopCarBlock;

/** 同品牌回调 */
@property (nonatomic, copy) dispatch_block_t sameBrandBlock;
/** 同价位回调 */
@property (nonatomic, copy) dispatch_block_t samePriceBlock;

@end
