//
//  DCBaseServiceCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCBaseServiceCell.h"

#import "DCBaseItem.h"

@interface DCBaseServiceCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation DCBaseServiceCell

- (void)setBaseItem:(DCBaseItem *)baseItem
{
    _baseItem = baseItem;
    
    self.iconImageView.image = [UIImage imageNamed:baseItem.imgs];
    
    self.titleLabel.text = baseItem.title;
    self.contentLabel.text = baseItem.content;
}


@end
