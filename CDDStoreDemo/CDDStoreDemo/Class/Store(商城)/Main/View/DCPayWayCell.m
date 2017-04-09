//
//  DCPayWayCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/4/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCPayWayCell.h"

#import "DCConsts.h"

@interface DCPayWayCell()

@property (nonatomic,strong) UIImageView *accessoryImageView;

@end

@implementation DCPayWayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView addSubview:self.accessoryImageView];
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (UIImageView *)accessoryImageView{
    if (!_accessoryImageView) {
        _accessoryImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenW - 35.0, 30.0, 20.0, 20.0)];
        [_accessoryImageView setImage:[UIImage imageNamed:@"payWay"]];
    }
    return _accessoryImageView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        [self.accessoryImageView setImage:[UIImage imageNamed:@"payWay_S"]];
    }else{
        [self.accessoryImageView setImage:[UIImage imageNamed:@"payWay"]];
    }
}


@end
