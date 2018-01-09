
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

#pragma mark - 拦截重新布局
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= DCMargin;
    frame.origin.y += DCMargin;
    
    frame.size.width -= DCMargin * 2;
    frame.origin.x += DCMargin;
    
    [super setFrame:frame];
}

#pragma mark - Setter Getter Methods
- (void)setAdItem:(DCAdressItem *)adItem
{
    _adItem = adItem;
    
    
    if (adItem.isDefault) {//判断是否是默认选择
        self.chooseButton.selected = YES;
    } else {
        self.chooseButton.selected = NO;
    }
}
#pragma mark - 编辑按钮点击
- (IBAction)editButtonClick {
    
}
#pragma mark - 删除按钮点击
- (IBAction)deleteButtonClick {
    
}

#pragma mark - 选择点击
- (IBAction)chooseDefaultButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    !_selectBtnClickBlock ? : _selectBtnClickBlock(sender.selected); //传递选择状态
}

@end
