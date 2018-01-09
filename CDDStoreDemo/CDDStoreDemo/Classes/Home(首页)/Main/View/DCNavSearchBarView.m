//
//  DCNavSearchBarView.m
//  CDDMall
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCNavSearchBarView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCNavSearchBarView ()

@end

static bool closeIntrinsic = false;//Intrinsic的影响

@implementation DCNavSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchClick)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


/**
 通过覆盖intrinsicContentSize函数修改自定义View的Intrinsic的大小
 @return CGSize
 */
-(CGSize)intrinsicContentSize
{
    if (closeIntrinsic) {
        return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
    } else {
        return CGSizeMake(self.dc_width, self.dc_height);
    }
}

- (void)setUpUI
{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    
    _placeholdLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _placeholdLabel.font = PFR14Font;
    _placeholdLabel.textColor = [UIColor whiteColor];

    _voiceImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_voiceImageBtn setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    [_voiceImageBtn addTarget:self action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:_placeholdLabel];
    [self addSubview:_voiceImageBtn];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _placeholdLabel.frame = CGRectMake(DCMargin, 0, self.dc_width - 50, self.dc_height);
    
    [_placeholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.equalTo(self)setOffset:DCMargin];
        make.top.equalTo(self);
        make.height.equalTo(self);
        
    }];
    [_voiceImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.equalTo(self)setOffset:-DCMargin];
        make.top.equalTo(self);
        make.height.equalTo(self);
    }];
    
    //设置边角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(2, 2)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];

}

#pragma mark - Setter Getter Methods

- (void)searchClick
{
    !_searchViewBlock ?: _searchViewBlock();
}

#pragma mark - 语音点击回调
- (void)voiceButtonClick {
    !_voiceButtonClickBlock ? : _voiceButtonClickBlock();
}

@end
