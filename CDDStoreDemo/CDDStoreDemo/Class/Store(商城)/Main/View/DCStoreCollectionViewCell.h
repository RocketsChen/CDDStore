//
//  DCStoreCollectionViewCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCStoreItem;

@interface DCStoreCollectionViewCell : UICollectionViewCell

/**
 0：列表视图
 1：格子视图
 */
@property (nonatomic, assign) BOOL isGrid;

/* 商品属性 */
@property (strong , nonatomic)DCStoreItem *storeItem;

@end
