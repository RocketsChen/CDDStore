//
//  DCDetailLikeItemCell.h
//  CDDMall
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCRecommendItem;
@interface DCDetailLikeItemCell : UICollectionViewCell

/* 推荐数据 */
@property (strong , nonatomic)DCRecommendItem *youLikeItem;

@end
