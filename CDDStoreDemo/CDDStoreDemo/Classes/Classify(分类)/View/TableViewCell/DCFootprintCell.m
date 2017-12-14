//
//  DCFootprintCell.m
//  CDDMall
//
//  Created by apple on 2017/6/15.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define FootprintScreenW ScreenW * 0.4

#import "DCFootprintCell.h"

// Controllers

// Models
#import "DCRecommendItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCFootprintCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodImageView;
/* 商品名称 */
@property (strong , nonatomic)UILabel *goodName;
/* 商品价格 */
@property (strong , nonatomic)UILabel *priceLabel;
@end

@implementation DCFootprintCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _goodImageView = [[UIImageView alloc] init];
    _goodImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodImageView];
    
    _goodName = [[UILabel alloc] init];
    _goodName.font = PFR12Font;
    [self addSubview:_goodName];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR13Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];

}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(FootprintScreenW * 0.9, FootprintScreenW * 0.9));
    }];
    
    [_goodName mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_goodImageView.mas_bottom)setOffset:5];
        make.left.mas_equalTo(_goodImageView);
        make.right.mas_equalTo(_goodImageView);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_goodName.mas_bottom)setOffset:5];
        make.left.mas_equalTo(_goodImageView);
        make.right.mas_equalTo(_goodImageView);
    }];
    
}

#pragma mark - Setter Getter Methods
- (void)setFootprintItem:(DCRecommendItem *)footprintItem
{
    _footprintItem = footprintItem;
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:footprintItem.image_url]];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[footprintItem.price floatValue]];
    _goodName.text = footprintItem.main_title;
}

@end
