//
//  DCHeaderReusableView.h
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCFiltrateItem;
@interface DCHeaderReusableView : UICollectionReusableView


@property (weak, nonatomic) IBOutlet UILabel *selectHeadLabel;

/* 头部数组 */
@property (strong , nonatomic)DCFiltrateItem *headFiltrate;

/** 头部点击 */
@property (nonatomic, copy) dispatch_block_t sectionClick;


@end
