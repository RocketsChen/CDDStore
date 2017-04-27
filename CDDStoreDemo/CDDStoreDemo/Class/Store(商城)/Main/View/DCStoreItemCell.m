//
//  DCStoreItemCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreItemCell.h"

#import "DCStoreItem.h"
#import "DCConsts.h"
#import "DCSpeedy.h"
#import "DCStoreCoverLabel.h"
#import "UIView+DCExtension.h"

#import <Masonry.h>

static UIView *coverView;

@interface DCStoreItemCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodstitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

@end

@implementation DCStoreItemCell
{
    UIButton *diffButton;
    UIButton *sameButton;
    DCStoreCoverLabel *nameLabel;
    DCStoreCoverLabel *desLabel;
    DCStoreCoverLabel *serLabel;
    DCStoreCoverLabel *exLabel;
    
}

- (void)setStoreItem:(DCStoreItem *)storeItem
{
    _storeItem = storeItem;
    
    self.iconImageView.image = [UIImage imageNamed:storeItem.goodspics];
    
    self.goodstitleLabel.text = storeItem.goods_title;
    
    self.salesLabel.text = [NSString stringWithFormat:@"销售 %@笔",storeItem.sales];
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %0.2f",[storeItem.price floatValue]];
    
    self.introduceLabel.text = storeItem.secondtitle;

}

- (IBAction)choseMoreButtonClick {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ //单列
        coverView = [UIButton buttonWithType:UIButtonTypeCustom];
    });
    coverView.dc_height = self.contentView.dc_height;
    coverView.dc_y = 0;
    coverView.dc_width = self.contentView.dc_width - CGRectGetMaxX(self.iconImageView.frame);
    coverView.dc_x = self.contentView.dc_width;
    [UIView animateWithDuration:0.5 animations:^{
        coverView.dc_x = CGRectGetMaxX(self.iconImageView.frame);
    }];
    
    coverView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
    [self.contentView addSubview:coverView];
    
    diffButton = [[UIButton alloc] init];
    [diffButton setTitle:@"无相同" forState:UIControlStateNormal];
    diffButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [diffButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [diffButton setBackgroundColor:[UIColor redColor]];
    [diffButton addTarget:self action:@selector(noDiff) forControlEvents:UIControlEventTouchUpInside];
    
    sameButton = [[UIButton alloc] init];
    [sameButton setTitle:@"找相似" forState:UIControlStateNormal];
    sameButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [sameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sameButton setBackgroundColor:[UIColor orangeColor]];
    [sameButton addTarget:self action:@selector(lookSame) forControlEvents:UIControlEventTouchUpInside];
    
    nameLabel = [[DCStoreCoverLabel alloc] init];
    nameLabel.text = @"RockectChen直营店";
    
    desLabel = [[DCStoreCoverLabel alloc] init];
    desLabel.text = @"描述 4.9         评论（12）";
    
    serLabel = [[DCStoreCoverLabel alloc] init];
    serLabel.text = @"服务 4.9         有图（4）";
    
    exLabel = [[DCStoreCoverLabel alloc] init];
    exLabel.text = @"物流 4.9         追加（6）";

    NSArray *array = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"."];
    [DCSpeedy setSomeOneChangeColor:desLabel SetSelectArray:array SetChangeColor:[UIColor orangeColor]];
    [DCSpeedy setSomeOneChangeColor:serLabel SetSelectArray:array SetChangeColor:[UIColor orangeColor]];
    [DCSpeedy setSomeOneChangeColor:exLabel SetSelectArray:array SetChangeColor:[UIColor orangeColor]];
    
    [coverView addSubview:diffButton];
    [coverView addSubview:sameButton];
    
    [coverView addSubview:nameLabel];
    [coverView addSubview:desLabel];
    [coverView addSubview:serLabel];
    [coverView addSubview:exLabel];
    
    
    [diffButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(coverView).multipliedBy(0.5);
        make.right.mas_equalTo(coverView);
        make.top.mas_equalTo(coverView);
        make.width.mas_equalTo(@(50));
    }];
    
    [sameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(coverView).multipliedBy(0.5);
        make.right.mas_equalTo(coverView);
        make.top.mas_equalTo(diffButton.mas_bottom);
        make.width.mas_equalTo(@(50));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(coverView.mas_left)setOffset:DCMargin];
        [make.right.mas_equalTo(sameButton.mas_left)setOffset:DCMargin];
        [make.top.mas_equalTo(coverView)setOffset:DCMargin];
        
    }];
    
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(coverView.mas_left)setOffset:DCMargin];
        [make.top.mas_equalTo(nameLabel.mas_bottom)setOffset:DCMargin];
        
    }];
    [serLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(coverView.mas_left)setOffset:DCMargin];
        [make.top.mas_equalTo(desLabel.mas_bottom)setOffset:4];
        
    }];
    [exLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(coverView.mas_left)setOffset:DCMargin];
        [make.top.mas_equalTo(serLabel.mas_bottom)setOffset:4];
        
    }];
    
    coverView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewRemove)];
    [coverView addGestureRecognizer:tap];
    
}

- (void)noDiff
{
    [self coverViewRemove];
}

- (void)lookSame
{
    [self coverViewRemove];
}


#pragma mark - 移除视图
- (void)coverViewRemove
{
    [UIView animateWithDuration:0.5 animations:^{
        coverView.dc_x = self.contentView.dc_width;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
        [nameLabel removeFromSuperview];
        [desLabel removeFromSuperview];
        [serLabel removeFromSuperview];
        [exLabel removeFromSuperview];
        [diffButton removeFromSuperview];
        [sameButton removeFromSuperview];
    }];
    
}

@end
