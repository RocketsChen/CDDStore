

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

@property (weak, nonatomic) IBOutlet DCPlaceholderTextView *detailTextView;
@property (weak, nonatomic) IBOutlet UITextField *rePersonField;

@property (weak, nonatomic) IBOutlet UITextField *rePhoneField;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

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
//    self.detailTextView.placeholder = @"请输入您的详细地址";
//    self.detailTextView.placeholderColor = [UIColor darkGrayColor];
}

#pragma mark - 选择地址
- (IBAction)addressButtonClick {
    !_selectAdBlock ? : _selectAdBlock();
}
#pragma mark - Setter Getter Methods

@end
