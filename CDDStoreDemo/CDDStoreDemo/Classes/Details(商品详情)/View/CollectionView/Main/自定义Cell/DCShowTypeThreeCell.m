//
//  DCShowTypeThreeCell.m
//  CDDMall
//
//  Created by apple on 2017/6/25.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCShowTypeThreeCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCShowTypeThreeCell ()



@end

@implementation DCShowTypeThreeCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}

- (void)setUpData
{
    self.isHasindicateButton = NO;
    self.leftTitleLable.text = @"运费";
    self.contentLabel.text = @"免运费";
    self.hintLabel.text = @"支持7天无理由退货";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.hintLabel.font = PFR10Font;
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"icon_duigou_small"];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.leftTitleLable.mas_right)setOffset:DCMargin];
        make.centerY.mas_equalTo(self.leftTitleLable);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTitleLable);
        [make.top.mas_equalTo(self.leftTitleLable.mas_bottom)setOffset:DCMargin];
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.iconImageView.mas_right)setOffset:DCMargin];
        make.centerY.mas_equalTo(self.iconImageView);
    }];
    
}

#pragma mark - Setter Getter Methods

@end
