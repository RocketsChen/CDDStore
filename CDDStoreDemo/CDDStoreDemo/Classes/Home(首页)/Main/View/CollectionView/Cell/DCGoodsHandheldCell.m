//
//  DCGoodsHandheldCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsHandheldCell.h"

// Controllers

// Models

// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCGoodsHandheldCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *handheldImageView;

@end

@implementation DCGoodsHandheldCell

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
    _handheldImageView = [[UIImageView alloc] init];
    _handheldImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_handheldImageView];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];

    [_handheldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setHandheldImage:(NSString *)handheldImage
{
    _handheldImage = handheldImage;
    
    [_handheldImageView sd_setImageWithURL:[NSURL URLWithString:handheldImage]];
}

@end
