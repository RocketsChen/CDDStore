//
//  DCStoreGridCollectionCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//
#pragma mark - 列表Cell
#import <UIKit/UIKit.h>

@class DCStoreItem;

@interface DCStoreGridCollectionCell : UICollectionViewCell

/* 商品属性 */
@property (strong , nonatomic)DCStoreItem *storeItem;


@property (nonatomic , copy) void(^choseMoreBlock)(UIImageView *image);


@end
