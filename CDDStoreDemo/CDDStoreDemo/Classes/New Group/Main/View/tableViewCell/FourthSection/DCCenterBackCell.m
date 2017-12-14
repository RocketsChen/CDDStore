//
//  DCCenterBackCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/13.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCenterBackCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCCenterBackCell ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;


@end

@implementation DCCenterBackCell

#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [DCSpeedy dc_chageControlCircularWith:_backButton AndSetCornerRadius:15 SetBorderWidth:1 SetBorderColor:RGB(227, 107, 97) canMasksToBounds:YES];
}

#pragma mark - Setter Getter Methods


@end
