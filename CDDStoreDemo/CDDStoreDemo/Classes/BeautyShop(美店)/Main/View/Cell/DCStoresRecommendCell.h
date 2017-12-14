//
//  DCStoresRecommendCell.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCBeautyShopItem;

@interface DCStoresRecommendCell : UICollectionViewCell

/* 上架点击回调 */
@property (copy,nonatomic)dispatch_block_t shelvesClickBlock;

/* 推荐数据 */
@property (strong , nonatomic)DCBeautyShopItem *shopItem;

@end
