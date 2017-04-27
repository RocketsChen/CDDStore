//
//  DCStoreCollectionViewCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#pragma mark - 视图Cell
#import <UIKit/UIKit.h>

@class DCStoreItem;

@interface DCStoreCollectionViewCell : UICollectionViewCell

/* 商品属性 */
@property (strong , nonatomic)DCStoreItem *storeItem;

@property (nonatomic , copy) void(^choseMoreBlock)(UIImageView *image);

@end
