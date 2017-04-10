//
//  DCSureOrderViewController.h
//  CDDStoreDemo
//
//  Created by apple on 2017/4/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCSureOrderViewController : UIViewController

/* 商品 */
@property (weak ,nonatomic) NSString *showShopStr;
/* 商品价格 */
@property (assign ,nonatomic) float showPriceStr;
/* 商品快递费 */
@property (weak, nonatomic) NSString *expressagePriceStr;
/** 购买数量 */
@property (nonatomic, assign) NSInteger buyNum;
/** 规格 */
@property (nonatomic, strong) NSString *standard;
/* 头像 */
@property (weak ,nonatomic) NSString *iconimage;

@end
