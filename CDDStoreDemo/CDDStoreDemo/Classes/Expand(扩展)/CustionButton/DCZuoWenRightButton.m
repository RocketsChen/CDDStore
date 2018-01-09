//
//  DCZuoWenRightButton.m
//  CDDMall
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCZuoWenRightButton.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCZuoWenRightButton ()



@end

@implementation DCZuoWenRightButton

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    //设置lable
    self.titleLabel.dc_x = 0;
    self.titleLabel.dc_centerY = self.dc_centerY;
    [self.titleLabel sizeToFit];
    
    //设置图片位置
    self.imageView.dc_x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    self.imageView.dc_centerY = self.dc_centerY;
    [self.imageView sizeToFit];

}

#pragma mark - Setter Getter Methods

@end
