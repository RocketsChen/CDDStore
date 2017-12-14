//
//  DCYouLikeHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCYouLikeHeadView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCYouLikeHeadView ()

@end

@implementation DCYouLikeHeadView

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
    _likeImageView = [[UIImageView alloc] init];
    _likeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_likeImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(150, 25));
    }];
}

#pragma mark - Setter Getter Methods


@end
