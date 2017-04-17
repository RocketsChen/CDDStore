//
//  DCSureOrderViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/4/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCSureOrderViewController.h"

#import "DCUserPayViewController.h"

@interface DCSureOrderViewController ()
/* 商品 */
@property (weak, nonatomic) IBOutlet UIImageView *shopIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopChoseLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopBuyCount;

/* 付款 */
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UILabel *totalNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *storePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastPayMoneyLabel;

/* 高 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topExViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleShopViewH;

@end

@implementation DCSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpShopInfo];

}


- (void)setUpShopInfo
{
    [_orderButton addTarget:self action:@selector(setUpJumpToPay) forControlEvents:UIControlEventTouchUpInside];
    
    _totalNumLabel.text = [NSString stringWithFormat:@"%zd 件",_buyNum];
    _storePriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",_showPriceStr];
    _lastPayMoneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",_showPriceStr];
    
    _shopIconImageView.image = [UIImage imageNamed:_iconimage];
    _shopChoseLabel.text = [NSString stringWithFormat:@"规格：%@",_standard];
    _shopTitleLabel.text = _showShopStr;
    _shopBuyCount.text = [NSString stringWithFormat:@"× %zd",_buyNum];
    _shopMoneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",_showPriceStr];
    
    
}

- (void)setUpJumpToPay
{
    DCUserPayViewController *payVc = [[DCUserPayViewController alloc] init];
    payVc.lastPayMoney = _showPriceStr;
    [self.navigationController pushViewController:payVc animated:YES];
}

@end
