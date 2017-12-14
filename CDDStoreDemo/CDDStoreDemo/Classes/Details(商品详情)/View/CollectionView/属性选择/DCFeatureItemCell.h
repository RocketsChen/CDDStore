//
//  DCFeatureItemCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCFeatureList;
@interface DCFeatureItemCell : UICollectionViewCell

/* 内容数据 */
@property (nonatomic , copy) DCFeatureList *content;

@end
