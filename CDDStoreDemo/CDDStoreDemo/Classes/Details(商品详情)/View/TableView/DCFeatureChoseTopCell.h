//
//  DCFeatureChoseTopCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCFeatureChoseTopCell : UITableViewCell

/** 取消点击回调 */
@property (nonatomic, copy) dispatch_block_t crossButtonClickBlock;

/* 商品价格 */
@property (strong , nonatomic)UILabel *goodPriceLabel;
/* 图片 */
@property (strong , nonatomic)UIImageView *goodImageView;
/* 选择属性 */
@property (strong , nonatomic)UILabel *chooseAttLabel;


@end
