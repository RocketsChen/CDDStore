//
//  DCShowTypeOneCell.m
//  CDDMall
//
//  Created by apple on 2017/6/25.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCShowTypeOneCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCShowTypeOneCell ()



@end

@implementation DCShowTypeOneCell

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
    self.hintLabel.text = @"可选增值服务";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.hintLabel.font = PFR12Font;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.leftTitleLable.mas_right)setOffset:DCMargin];
        make.width.mas_equalTo(self).multipliedBy(0.78);
        make.centerY.mas_equalTo(self.leftTitleLable);
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentLabel);
        [make.top.mas_equalTo(self.contentLabel.mas_bottom)setOffset:8];
    }];
}

#pragma mark - Setter Getter Methods

@end
