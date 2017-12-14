//
//  DCDeatilCustomHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCDeatilCustomHeadView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCDeatilCustomHeadView ()

/* 猜你喜欢 */
@property (strong ,nonatomic) UILabel *guessMarkLabel;


@end

@implementation DCDeatilCustomHeadView

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
    self.backgroundColor = [UIColor whiteColor];
    
    _guessMarkLabel = [[UILabel alloc] init];
    _guessMarkLabel.text = @"猜你喜欢";
    _guessMarkLabel.font = PFR15Font;
    [self addSubview:_guessMarkLabel];
    
    _guessMarkLabel.frame = CGRectMake(DCMargin, 0, 200, self.dc_height);
}

#pragma mark - Setter Getter Methods


@end
