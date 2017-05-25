//
//  DCStoreHeadPriceCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCStoreHeadPriceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *repertoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *attributeLabel;


/* 点击回调 */
@property (nonatomic, copy) void(^dismissButtonClickBlock)();



@end
