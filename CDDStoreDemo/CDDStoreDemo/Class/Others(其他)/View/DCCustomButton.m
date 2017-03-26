//
//  DCCustomButton.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCCustomButton.h"

#import "DCConsts.h"

#import "UIView+DCExtension.h"

@implementation DCCustomButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    //    [self sizeToFit];
    //sizeToFit算完后加三倍的间距
    self.dc_width += DCMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.dc_centerY = self.dc_centerY;
    self.titleLabel.dc_x = DCMargin;
    self.imageView.dc_centerY = self.dc_centerY;
    self.imageView.dc_x = CGRectGetMaxX(self.titleLabel.frame) + 1/3 * DCMargin;
}

@end
