//
//  DCBeautyShopItem.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCBeautyShopItem : NSObject

/* 图片 */
@property (nonatomic, copy) NSString *shopImageUrl;
/* 商品标题 */
@property (nonatomic, copy) NSString *shopTitle;
/* 商品佣金 */
@property (nonatomic, copy) NSString *shopCommission;
/* 商品金额 */
@property (nonatomic, copy) NSString *shopAmount;


@end
