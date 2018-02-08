//
//  DCAdressDateBase.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/7.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCAdressItem;

@interface DCAdressDateBase : NSObject

/* 地址数据 */
@property (strong , nonatomic)DCAdressItem *adressItem;


/**
 DataBase数据

 @return 数据
 */
+ (instancetype)sharedDataBase;


#pragma mark - Adress


/**
 新增地址

 @param adress 地址
 */
- (void)addNewAdress:(DCAdressItem *)adress;

/**
 删除地址

 @param adress 地址
 */
- (void)deleteAdress:(DCAdressItem *)adress;

/**
 更新地址

 @param adress 地址
 */
- (void)updateAdress:(DCAdressItem *)adress;

/**
 *  获取所有数据
 *
 */
- (NSMutableArray *)getAllAdressItem;



@end
