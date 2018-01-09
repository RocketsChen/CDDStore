//
//  DCNewFeatureCell.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCNewFeatureCell : UICollectionViewCell

/* imageView */
@property (strong , nonatomic)UIImageView *nfImageView;

/** 隐藏新特性按钮点击回调 */
@property (nonatomic, copy) dispatch_block_t hideButtonClickBlock;

/* 跳过图片素材 */
@property (strong , nonatomic)NSString *hideBtnImg;

/**
 用来获取页码
 
 @param currentIndex 当前index
 @param lastIndex 最后index
 */
- (void)dc_GetCurrentPageIndex:(NSInteger)currentIndex lastPageIndex:(NSInteger)lastIndex;

@end
