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
/* 商品库存*/
@property (weak, nonatomic) NSString *stockStr;
/* 商品价格 */
@property (weak ,nonatomic) NSString *shopPrice;
/* 商品介绍 */
@property (weak ,nonatomic) NSString *introduce;
/* 商品标题 */
@property (weak ,nonatomic) NSString *goods_title;
/* 商品快递费 */
@property (weak, nonatomic) NSString *expressage;
/* 商品已售出量 */
@property (weak, nonatomic) NSString *saleCount;
/* 商品地点 */
@property (weak, nonatomic) NSString *site;

@end
