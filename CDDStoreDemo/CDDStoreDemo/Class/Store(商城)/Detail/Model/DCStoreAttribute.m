//
//  DCStoreAttribute.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreAttribute.h"
#import "DCStore_list.h"

#import <MJExtension.h>


@implementation DCStoreAttribute

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"DCStore_list"
             };
}

@end
