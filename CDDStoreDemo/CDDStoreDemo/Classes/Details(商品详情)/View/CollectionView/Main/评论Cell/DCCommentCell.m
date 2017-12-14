//
//  DCCommentCell.m
//  CDDMall
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCommentCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCCommentCell ()

/* 头像 */
@property (strong , nonatomic)UIImageView *iconImageView;
/* 昵称 */
@property (strong , nonatomic)UILabel *nickNameLabel;

/* 评论内容 */
@property (strong , nonatomic)UILabel *contentLabel;
/* 规格 */
@property (strong , nonatomic)UILabel *etalonLabel;
/* 时间 */
@property (strong , nonatomic)UILabel *timeLabel;

@end

@implementation DCCommentCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_iconImageView];
    
    _nickNameLabel = [[UILabel alloc] init];
    _nickNameLabel.font = PFR11Font;
    [self addSubview:_nickNameLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = PFR12Font;
    [self addSubview:_contentLabel];
    
    _etalonLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor lightGrayColor];
    _contentLabel.font = PFR11Font;
    [self addSubview:_contentLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = _contentLabel.textColor;
    _timeLabel.font = PFR10Font;
    [self addSubview:_timeLabel];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_iconImageView.mas_right)setOffset:DCMargin];
        make.centerY.mas_equalTo(_iconImageView);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView);
        [make.top.mas_equalTo(_iconImageView.mas_bottom)setOffset:DCMargin];
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
    }];
    
    [_etalonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView);
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.top.mas_equalTo(_contentLabel.mas_bottom)setOffset:DCMargin];
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView);
    }];
}

#pragma mark - Setter Getter Methods


@end
