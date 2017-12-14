//
//  DCColonInsView.m
//  CDDMall
//
//  Created by apple on 2017/6/15.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCColonInsView.h"

// Controllers

// Models

// Views
#import "DCUpDownButton.h"
// Vendors

// Categories

// Others

@interface DCColonInsView ()

/* 收藏按钮 */
@property (strong , nonatomic)UIButton *collectButton;
/* 加入购物车按钮 */
@property (strong , nonatomic)UIButton *addShopCarButton;

@end

@implementation DCColonInsView

#pragma mark - Intial
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_collectButton];
    _collectButton.tag = 0;
    _collectButton.backgroundColor = [UIColor orangeColor];
    [_collectButton setImage:[UIImage imageNamed:@"search_list_collect_icon"] forState:UIControlStateNormal];
    _collectButton.frame = CGRectMake(self.dc_width - 80, 0, 80, self.dc_height * 0.5);
    [_collectButton addTarget:self action:@selector(setUpClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _addShopCarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_addShopCarButton];
    _addShopCarButton.tag = 1;
    _addShopCarButton.backgroundColor = [UIColor redColor];
    [_addShopCarButton setImage:[UIImage imageNamed:@"search_list_addcart_icon"] forState:UIControlStateNormal];
    _addShopCarButton.frame = CGRectMake(self.dc_width - 80,self.dc_height * 0.5, 80, self.dc_height * 0.5);
    [_addShopCarButton addTarget:self action:@selector(setUpClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *titles = @[@"同品牌",@"同价位"];
    NSArray *images = @[@"search_list_samebrand_icon",@"search_list_sameprice_icon"];
    CGFloat buttonX = (self.dc_width - _addShopCarButton.dc_width) / 2;
    CGFloat buttonW = 50;
    CGFloat buttonH = self.dc_height * 0.5;
    
    for (NSInteger i = 0; i < images.count; i++) {
        DCUpDownButton *button = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = PFR12Font;
        CGFloat buttonY = i * buttonH;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag  = i + 2;
        [button addTarget:self action:@selector(setUpClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }

}

#pragma mark - Setter Getter Methods

- (void)setUpClickAction:(UIButton *)button
{
    if (button.tag == 0) {//收藏
        !_collectionBlock ? : _collectionBlock();
    }else if (button.tag == 1){//加入购车
        !_addShopCarBlock ? : _addShopCarBlock();
    }else if (button.tag == 2){//同品牌
        !_sameBrandBlock ? : _sameBrandBlock();
    }else if (button.tag == 3){//同价位
        !_samePriceBlock ? : _samePriceBlock();
    }
}

@end
