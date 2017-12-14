//
//  DCBeautyShopRecommendCell.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCBeautyShopItem;

@interface DCBeautyShopRecommendCell : UICollectionViewCell

/* 数据 */
@property (strong , nonatomic)NSMutableArray<DCBeautyShopItem *> *beaShopItem;

@end
