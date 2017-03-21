//
//  DCStoreDetailViewController.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCStoreDetailViewController : UIPageViewController

/* 商品 id*/
@property (strong , nonatomic)NSString *goodsid;
/* 商品头像 */
@property (strong , nonatomic)NSString *goodspics;
/* 商品库存*/
@property (weak, nonatomic) NSString *stockStr;
/* 商品价格 */
@property (weak ,nonatomic) NSString *shopPrice;
/* 商品介绍 */
@property (weak ,nonatomic) NSString *introduce;

@end
