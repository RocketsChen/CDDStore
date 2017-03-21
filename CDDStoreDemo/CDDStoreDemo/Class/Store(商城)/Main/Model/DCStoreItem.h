//
//  DCStoreItem.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DCStoreItem : NSObject

/** 商品_id */
@property (nonatomic, copy) NSString *goodsid;
/** 商品标题 */
@property (nonatomic, copy) NSString *goods_title;
/** 商品价格 */
@property (nonatomic, copy) NSString *price;
/** 商品种类 */
@property (nonatomic, copy) NSString *categoryid;
/** 商品存货 */
@property (nonatomic, copy) NSString *stock;
/** 已售出 */
@property (nonatomic, copy) NSString *sales;
/** 二级标题 */
@property (nonatomic, copy) NSString *secondtitle;
/** 商品头像 */
@property (nonatomic, copy) NSString *goodspics;


/** cell行高 */
@property (nonatomic , assign) CGFloat cellHeight;

@end
