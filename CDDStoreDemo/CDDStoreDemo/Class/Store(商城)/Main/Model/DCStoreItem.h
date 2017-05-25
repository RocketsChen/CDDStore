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

/** 商品价格 */
@property (nonatomic, copy) NSString *price;
/** 商品存货 */
@property (nonatomic, copy) NSString *stock;
/** 已售出 */
@property (nonatomic, copy) NSString *sales;
/** 二级标题 */
@property (nonatomic, copy) NSString *secondtitle;
/** 商品头像 */
@property (nonatomic, copy) NSString *goodspics;
/** 商品标题 */
@property (nonatomic, copy) NSString *goods_title;


/* 商品快递费 */
@property (copy, nonatomic) NSString *expressage;
/* 商品已售出量 */
@property (copy, nonatomic) NSString *sale_count;
/* 商品地点 */
@property (copy, nonatomic) NSString *goods_address;

/** cell行高 */
@property (nonatomic , assign) CGFloat cellHeight;



/** cell行高 */
@property (nonatomic , assign) CGFloat isGardHeight;
/** cell行高 */
@property (nonatomic , assign) CGFloat isCellHeight;

@end
