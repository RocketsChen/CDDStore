//
//  DCRecommendCell.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCRecommendItem;
@interface DCRecommendCell : UICollectionViewCell

/* 推荐商品数据 */
@property (strong , nonatomic)DCRecommendItem *recommendItem;

@end
