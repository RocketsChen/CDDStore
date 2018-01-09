
//
//  NSObject+DCNull.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "NSObject+DCNull.h"

@implementation NSObject (DCNull)

#pragma mark - 判断一个对象是否为空
- (BOOL)dc_isNull
{
    if ([self isEqual:[NSNull null]]) {
        return YES;
        
    }else if ([self isEqual:[NSNull class]]){
        return YES;
    }else{
        if (self == nil) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([((NSString *)self) isEqualToString:@"(null)"]) {
            return YES;
        }
    }
    
    return NO;
}


@end
