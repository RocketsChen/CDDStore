//
//  DCCommentPicCell.h
//  CDDMall
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCCommentPicItem;
@interface DCCommentPicCell : UICollectionViewCell

/* 图片评论 */
@property (strong , nonatomic)DCCommentPicItem *picItem;

/* 图片 */
@property (strong , nonatomic)UIImageView *pciImageView;

@end
