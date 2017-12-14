//
//  DCCustionButton.m
//  CDDMall
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCustionButton.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCCustionButton ()



@end

@implementation DCCustionButton

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
    self.titleLabel.font = PFR14Font;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    //计算完加一个艰巨
    self.dc_width += DCMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.dc_x = self.dc_width * 0.3;
    self.imageView.dc_x = CGRectGetMaxX(self.titleLabel.frame) + DCMargin;
}
#pragma mark - Setter Getter Methods

@end
