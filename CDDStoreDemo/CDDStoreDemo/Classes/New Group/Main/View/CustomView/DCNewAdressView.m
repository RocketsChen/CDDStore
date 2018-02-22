

//
//  DCNewAdressView.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/19.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCNewAdressView.h"

// Controllers

// Models

// Views
#import "DCPlaceholderTextView.h"
// Vendors

// Categories

// Others

@interface DCNewAdressView ()

@end

@implementation DCNewAdressView

#pragma mark - Intial
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUpBase];
}

- (void)setUpBase
{
    
}


#pragma mark - 选择地址
- (IBAction)addressButtonClick {
    !_selectAdBlock ? : _selectAdBlock();
}
#pragma mark - Setter Getter Methods

@end
