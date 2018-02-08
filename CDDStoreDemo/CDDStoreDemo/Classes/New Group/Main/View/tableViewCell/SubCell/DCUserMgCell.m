//
//  DCUserMgCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/18.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCUserMgCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCUserMgCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


@end

@implementation DCUserMgCell

#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

#pragma mark - Setter Getter Methods
- (void)setTitleContent:(NSString *)titleContent
{
    _titleContent = titleContent;
    self.titleLabel.text = titleContent;
}

- (void)setSubTitleContent:(NSString *)subTitleContent
{
    _subTitleContent = subTitleContent;
    self.subTitleLabel.text = subTitleContent;
    
    //变色
    [DCSpeedy dc_setSomeOneChangeColor:_subTitleLabel SetSelectArray:@[@"低",@"中",@"高"] SetChangeColor:[UIColor orangeColor]];
}



@end
