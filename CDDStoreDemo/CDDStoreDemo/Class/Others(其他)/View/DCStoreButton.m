//
//  DCStoreButton.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreButton.h"

#import "UIView+DCExtension.h"

@implementation DCStoreButton

-(void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片位置
    self.imageView.dc_centerY = self.dc_centerY - 5;
    self.imageView.dc_centerX = self.dc_width * 0.5;
    
    //自己计算文字的宽
    [self.titleLabel sizeToFit];
    //设置lable
    self.titleLabel.dc_centerX = self.dc_width * 0.5;
    self.titleLabel.dc_y = self.imageView.dc_bottom +  5;
    
    
}

@end
