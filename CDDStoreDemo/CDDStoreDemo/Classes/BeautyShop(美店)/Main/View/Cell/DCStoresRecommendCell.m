//
//  DCStoresRecommendCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCStoresRecommendCell.h"
#import "DCBeautyShopItem.h"
#import <UIImageView+WebCache.h>

@interface DCStoresRecommendCell()
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ghjLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopMoneyLabel;
@end

@implementation DCStoresRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


#pragma mark - 上架按钮点击
- (IBAction)shelvesButtonClick {
}

- (void)setShopItem:(DCBeautyShopItem *)shopItem
{
    _shopItem = shopItem;
    WEAKSELF
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shopItem.shopImageUrl] placeholderImage:[UIImage imageNamed:@"default_160"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.shopImageView.layer.cornerRadius = 8;
        weakSelf.shopImageView.layer.masksToBounds = YES;
    }];
    
    self.shopTitleLabel.text = shopItem.shopTitle;
    self.ghjLabel.text = [NSString stringWithFormat:@"%@国美币",shopItem.shopCommission];
    self.shopMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",shopItem.shopAmount];
    
}

@end
