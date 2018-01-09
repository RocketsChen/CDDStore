//
//  DCAdressItem.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/19.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCAdressItem : NSObject


/* 用户名 */
@property (nonatomic, copy) NSString *userName;
/* 用户电话 */
@property (nonatomic, copy) NSString *userPhone;
/* 用户地址 */
@property (nonatomic, copy) NSString *userAdress;

/* 默认地址 */
@property (nonatomic,assign) BOOL isDefault;

@end
