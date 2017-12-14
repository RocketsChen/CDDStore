

//
//  DCCenterBeaShopCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/13.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCenterBeaShopCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCCenterBeaShopCell ()

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIButton *controlButton;

@end

@implementation DCCenterBeaShopCell

#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];

    _bottomView.backgroundColor = DCBGColor;
    
    [DCSpeedy dc_chageControlCircularWith:_controlButton AndSetCornerRadius:15 SetBorderWidth:1 SetBorderColor:RGB(227, 107, 97) canMasksToBounds:YES];
}

#pragma mark - Setter Getter Methods


@end
