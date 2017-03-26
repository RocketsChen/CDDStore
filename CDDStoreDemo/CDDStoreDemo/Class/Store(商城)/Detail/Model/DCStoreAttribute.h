//
//  DCStoreAttribute.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCStore_attr,DCStore_list;

@interface DCStoreAttribute : NSObject

/* 名字 */
@property (strong , nonatomic)DCStore_attr *attr;
/* 数组 */
@property (strong , nonatomic)NSArray<DCStore_list *> *list;

@end
