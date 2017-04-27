//
//  DCStoreItemCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCStoreItem;

@interface DCStoreItemCell : UITableViewCell

/* 商品属性 */
@property (strong , nonatomic)DCStoreItem *storeItem;

@property (nonatomic , copy) void(^choseMoreBlock)(UIImageView *image);

@end
