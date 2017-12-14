//
//  DCStoresRecommendHeaderView.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCZuoWenRightButton.h"

@interface DCStoresRecommendHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *headRecommendLabel;
@property (weak, nonatomic) IBOutlet DCZuoWenRightButton *rightMoreButton;

@end
