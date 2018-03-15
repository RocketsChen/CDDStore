//
//  NSURL+DCHook.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/3/3.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (DCHook)

#pragma mark - 自定义方法
+ (instancetype)DC_URLWithString:(NSString *)string;

@end
