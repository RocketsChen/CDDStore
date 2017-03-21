//
//  DCStoreMainViewController.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCStoreMainViewController : UIViewController

/* 商品 id*/
@property (strong , nonatomic)NSString *goodsid;
/* 商品图片*/
@property (strong , nonatomic)NSString *goodspics;
/* 商品标题 */
@property (weak ,nonatomic) UILabel *showShopLabel;
/* 商品价格 */
@property (weak ,nonatomic) UILabel *showMoneyLabel;
/* 商品快递费 */
@property (weak, nonatomic) UILabel *expressageLabel;
/* 商品已售出量 */
@property (weak, nonatomic) UILabel *saleCountLabel;
/* 商品地点 */
@property (weak, nonatomic) UILabel *siteLabel;
/* 商品第二介绍 */
@property (weak, nonatomic) UILabel *secondtitleLabel;
/* 商品库存*/
@property (weak, nonatomic) NSString *stockStr;

/* 商品详情介绍*/
@property (weak, nonatomic) NSString *introduce;


@end
