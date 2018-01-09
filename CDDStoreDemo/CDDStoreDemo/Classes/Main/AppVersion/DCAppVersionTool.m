//
//  DCAppVersionTool.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCAppVersionTool.h"

@implementation DCAppVersionTool


// 获取保存的上一个版本信息
+ (NSString *)dc_GetLastOneAppVersion {
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"AppVersion"];
}

// 保存新版本信息（偏好设置）
+ (void)dc_SaveNewAppVersion:(NSString *)version {
    
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"AppVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
