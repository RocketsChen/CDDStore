//
//  DCRecommendReusableView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCRecommendReusableView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCRecommendReusableView ()

/* 头部推荐标题 */
@property (strong , nonatomic)UILabel *recommendLabel;

@end

@implementation DCRecommendReusableView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _recommendLabel = [[UILabel alloc] init];
    _recommendLabel.text = @"大家都在买";
    _recommendLabel.textColor = [UIColor darkGrayColor];
    _recommendLabel.font = PFR14Font;
    
    [self addSubview:_recommendLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        [make.left.mas_equalTo(self)setOffset:DCMargin];
    }];
    
}

#pragma mark - Setter Getter Methods


@end
