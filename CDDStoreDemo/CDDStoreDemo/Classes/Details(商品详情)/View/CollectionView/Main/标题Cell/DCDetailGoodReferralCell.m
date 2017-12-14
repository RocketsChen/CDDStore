//
//  DCDetailGoodReferralCell.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCDetailGoodReferralCell.h"

// Controllers

// Models

// Views
#import "DCUpDownButton.h"
// Vendors

// Categories

// Others

@interface DCDetailGoodReferralCell ()

/* 自营 */
@property (strong , nonatomic)UIImageView *autotrophyImageView;
/* 分享按钮 */
@property (strong , nonatomic)DCUpDownButton *shareButton;

@end

@implementation DCDetailGoodReferralCell

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
    self.backgroundColor = [UIColor whiteColor];
    
    _autotrophyImageView = [[UIImageView alloc] init];
    [self addSubview:_autotrophyImageView];
    _autotrophyImageView.image = [UIImage imageNamed:@"detail_title_ziying_tag"];
    
    _goodTitleLabel = [[UILabel alloc] init];
    _goodTitleLabel.font = PFR16Font;
    _goodTitleLabel.numberOfLines = 0;
    [self addSubview:_goodTitleLabel];
    
    _goodPriceLabel = [[UILabel alloc] init];
    _goodPriceLabel.font = PFR20Font;
    _goodPriceLabel.textColor = [UIColor redColor];
    [self addSubview:_goodPriceLabel];
    
    _goodSubtitleLabel = [[UILabel alloc] init];
    _goodSubtitleLabel.font = PFR12Font;
    _goodSubtitleLabel.numberOfLines = 0;
    _goodSubtitleLabel.textColor = RGB(233, 35, 46);
    [self addSubview:_goodSubtitleLabel];
    
    _shareButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
    [_shareButton setTitle:@"分享" forState:0];
    [_shareButton setImage:[UIImage imageNamed:@"icon_fenxiang2"] forState:0];
    [_shareButton setTitleColor:[UIColor blackColor] forState:0];
    _shareButton.titleLabel.font = PFR10Font;
    [self addSubview:_shareButton];
    [_shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [DCSpeedy dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15]];
    
    
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_autotrophyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
    }];
    
    [_goodTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(_autotrophyImageView)setOffset:-3];
        [make.right.mas_equalTo(self)setOffset:-DCMargin * 5];
    }];

    
    [_goodSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_autotrophyImageView);
        [make.right.mas_equalTo(self)setOffset:-DCMargin * 5];
        [make.top.mas_equalTo(_goodTitleLabel.mas_bottom)setOffset:DCMargin];
    }];
    
    [_goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_autotrophyImageView);
        [make.top.mas_equalTo(_goodSubtitleLabel.mas_bottom)setOffset:DCMargin];
    }];
    
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
    }];
    
    [DCSpeedy dc_setUpLongLineWith:_goodTitleLabel WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15] WithHightRatio:0.6];
}


#pragma mark - 分享按钮点击
- (void)shareButtonClick
{
    !_shareButtonClickBlock ? : _shareButtonClickBlock();
}

#pragma mark - Setter Getter Methods


@end
