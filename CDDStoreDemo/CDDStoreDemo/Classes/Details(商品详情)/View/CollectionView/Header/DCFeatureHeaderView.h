//
//  DCFeatureHeaderView.h
//  CDDStoreDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCFeatureTitleItem;
@interface DCFeatureHeaderView : UICollectionReusableView

/** 标题数据 */
@property (nonatomic, strong) DCFeatureTitleItem *headTitle;

@end
