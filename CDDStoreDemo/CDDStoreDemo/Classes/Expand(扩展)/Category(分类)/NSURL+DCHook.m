//
//  NSURL+DCHook.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/3/3.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "NSURL+DCHook.h"
#import <objc/runtime.h>

@implementation NSURL (DCHook)

+ (void)load
{
    //获取两个
    Method urlMethod = class_getClassMethod(self, @selector(URLWithString:));
    Method dcHookMethod = class_getClassMethod(self, @selector(DC_URLWithString:));
    
    //交换方法IMP
    method_exchangeImplementations(urlMethod, dcHookMethod);
}

#pragma mark - 自定义方法
+ (instancetype)DC_URLWithString:(NSString *)URLString
{
    NSURL *url = [self DC_URLWithString:URLString];
    if (url == nil) {
        NSLog(@"url为空");
    }
    return url;
}

@end
