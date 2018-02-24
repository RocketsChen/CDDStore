//
//  DCCometItemCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/23.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "DCCometItemCell.h"

@interface DCCometItemCell()

@end

@implementation DCCometItemCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}



- (void)setUpUI
{
    _itemLabel = [UILabel new];
    _itemLabel.backgroundColor = RGB(254, 220, 233);
    _itemLabel.textAlignment = NSTextAlignmentCenter;
    _itemLabel.font = PFR13Font;
    _itemLabel.textColor = [UIColor darkGrayColor];
    _itemLabel.frame = self.bounds;
    [self addSubview:_itemLabel];
    
    _itemLabel.layer.cornerRadius = 15;
    _itemLabel.layer.masksToBounds = YES;
}


- (void)setSelected:(BOOL)selected
{
    if (selected) {
        _itemLabel.backgroundColor = RGB(235, 0, 72);
        _itemLabel.textColor = [UIColor whiteColor];
    }else{
        _itemLabel.backgroundColor = RGB(254, 220, 233);
        _itemLabel.textColor = [UIColor darkGrayColor];
    }
}



@end
