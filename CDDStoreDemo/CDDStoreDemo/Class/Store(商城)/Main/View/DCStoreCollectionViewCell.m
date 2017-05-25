//
//  DCStoreCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreCollectionViewCell.h"

#import "DCConsts.h"
#import "DCSpeedy.h"
#import "DCStoreItem.h"
#import "UIView+DCExtension.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface DCStoreCollectionViewCell()

@property (strong, nonatomic)  UIImageView *iconImageView;
@property (strong, nonatomic)  UILabel *goodstitleLabel;
@property (strong, nonatomic)  UILabel *salesLabel;
@property (strong, nonatomic)  UILabel *priceLabel;
@property (strong, nonatomic)  UILabel *introduceLabel;
@property (strong, nonatomic)  UIButton *choseMoreBtn;
@end

@implementation DCStoreCollectionViewCell

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpCell];
    }
    return self;
}
- (void)setUpCell
{
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_iconImageView];
    
    _goodstitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _goodstitleLabel.numberOfLines = 0;
    _goodstitleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_goodstitleLabel];
    
    _introduceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _introduceLabel.textColor = [UIColor orangeColor];
    _introduceLabel.numberOfLines = 0;
    _introduceLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_introduceLabel];
    
    _salesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _salesLabel.textColor = [UIColor lightGrayColor];
    _salesLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_salesLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_priceLabel];
    
    _choseMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_choseMoreBtn addTarget:self action:@selector(choseMoreBynClick) forControlEvents:UIControlEventTouchUpInside];
    [_choseMoreBtn setImage:[UIImage imageNamed:@"choseMore"] forState:UIControlStateNormal];
    [self.contentView addSubview:_choseMoreBtn];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.contentView)setOffset:0];
        [make.right.mas_equalTo(self.contentView)setOffset:-0];
        [make.top.mas_equalTo(self.contentView)setOffset:0];
        make.height.mas_equalTo(_iconImageView.mas_width);
    }];
    
    [_goodstitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_iconImageView.mas_left)setOffset:5];
        [make.right.mas_equalTo(_iconImageView)setOffset:-5];
        [make.top.mas_equalTo(_iconImageView.mas_bottom)setOffset:DCMargin];;
    }];
    
    [_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodstitleLabel);
        make.right.mas_equalTo(_goodstitleLabel);
        [make.top.mas_equalTo(_goodstitleLabel.mas_bottom)setOffset:4];
    }];
    
    [_salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_introduceLabel);
        make.right.mas_equalTo(_introduceLabel);
        [make.top.mas_equalTo(_introduceLabel.mas_bottom)setOffset:4];
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_salesLabel);
        make.right.mas_equalTo(_salesLabel);
        [make.top.mas_equalTo(_salesLabel.mas_bottom)setOffset:4];
    }];
    
    [_choseMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self.contentView.mas_right)setOffset:-10];
        make.bottom.mas_equalTo(_priceLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

- (void)setStoreItem:(DCStoreItem *)storeItem
{
    _storeItem = storeItem;
    
    self.iconImageView.image = [UIImage imageNamed:storeItem.goodspics];
    self.goodstitleLabel.text = storeItem.goods_title;
    self.salesLabel.text = [NSString stringWithFormat:@"销售 %@笔",storeItem.sales];
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %0.2f",[storeItem.price floatValue]];
    self.introduceLabel.text = storeItem.secondtitle;
    
}

- (void)choseMoreBynClick
{
    !_choseMoreBlock ? : _choseMoreBlock(_iconImageView);
}


@end
