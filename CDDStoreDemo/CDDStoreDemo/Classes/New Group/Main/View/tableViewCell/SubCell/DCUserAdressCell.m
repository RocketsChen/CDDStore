
//
//  DCUserAdressCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/19.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCUserAdressCell.h"

// Controllers

// Models
#import "DCAdressItem.h"
// Views

// Vendors

// Categories

// Others

@interface DCUserAdressCell ()

@property (weak, nonatomic) IBOutlet UILabel *perNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *perPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *perDetailLabel;

@end

@implementation DCUserAdressCell

#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - Setter Getter Methods
- (void)setAdItem:(DCAdressItem *)adItem
{
    _adItem = adItem;
    
    self.perNameLabel.text = adItem.userName;
    self.perPhoneLabel.text = [DCSpeedy dc_encryptionDisplayMessageWith:adItem.userPhone WithFirstIndex:3];
    self.perDetailLabel.text = [NSString stringWithFormat:@"%@ %@",adItem.chooseAdress,adItem.userAdress];
    
    if ([adItem.isDefault isEqualToString:@"2"]) {//判断是否是默认选择
        self.chooseButton.selected = YES;
    } else {
        self.chooseButton.selected = NO;
    }
}
#pragma mark - 编辑按钮点击
- (IBAction)editButtonClick {
    
    !_editClickBlock ? : _editClickBlock();
}
#pragma mark - 删除按钮点击
- (IBAction)deleteButtonClick {
    !_deleteClickBlock ? : _deleteClickBlock();
}


#pragma mark - 选择点击
- (IBAction)chooseDefaultButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    !_selectBtnClickBlock ? : _selectBtnClickBlock(sender.selected); //传递选择状态
}

@end
