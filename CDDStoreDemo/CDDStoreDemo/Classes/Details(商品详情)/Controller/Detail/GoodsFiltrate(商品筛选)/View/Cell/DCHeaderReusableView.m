//
//  DCHeaderReusableView.m
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCHeaderReusableView.h"

// Controllers

// Models
#import "DCFiltrateItem.h"
// Views

// Vendors

// Categories

// Others

@interface DCHeaderReusableView ()

@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@property (weak, nonatomic) IBOutlet UIButton *upDownButton;

@end

@implementation DCHeaderReusableView

#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setHeadFiltrate:(DCFiltrateItem *)headFiltrate
{
    _headLabel.text = headFiltrate.headTitle;
    
    if (headFiltrate.isOpen) { //箭头
        [self.upDownButton setImage:[UIImage imageNamed:@"arrow_down"] forState:0];
    }else{
        [self.upDownButton setImage:[UIImage imageNamed:@"arrow_up"] forState:0];
    }
}


- (IBAction)upDownClick:(UIButton *)sender {
    
    !_sectionClick ? : _sectionClick();

}



@end
