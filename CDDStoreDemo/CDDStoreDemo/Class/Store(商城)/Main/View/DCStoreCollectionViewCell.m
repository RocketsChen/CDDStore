//
//  DCStoreCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreCollectionViewCell.h"

#import "DCConsts.h"
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
    _goodstitleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:_goodstitleLabel];
    
    _introduceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _introduceLabel.textColor = [UIColor orangeColor];
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
    
}

- (void)setIsGrid:(BOOL)isGrid
{
    _isGrid = isGrid;
    if (isGrid) {//列表格式
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.left.mas_equalTo(self.contentView)setOffset:DCMargin];
            [make.right.mas_equalTo(self.contentView)setOffset:-DCMargin];
            [make.top.mas_equalTo(self.contentView)setOffset:DCMargin];
            make.height.mas_equalTo(@(self.contentView.dc_width));
        }];
        
        [_goodstitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImageView.mas_left);
            make.width.mas_equalTo(_iconImageView);
            [make.top.mas_equalTo(_iconImageView)setOffset:DCMargin];;
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
    }else{//格子模式
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.left.mas_equalTo(self.contentView)setOffset:DCMargin];
            [make.top.mas_equalTo(self.contentView)setOffset:DCMargin];
            make.size.mas_equalTo(CGSizeMake(77, 77));
        }];
        [_goodstitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.left.mas_equalTo(_iconImageView.mas_right)setOffset:DCMargin];
            [make.right.mas_equalTo(self.contentView)setOffset:-DCMargin];
            make.top.mas_equalTo(_iconImageView);
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
    }
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


@end
