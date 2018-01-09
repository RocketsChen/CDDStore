//
//  DCAppVersionTool.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCAppVersionTool : NSObject

/**
 *  获取之前保存的版本
 *
 *  @return NSString类型的AppVersion
 */
+ (NSString *)dc_GetLastOneAppVersion;
/**
 *  保存新版本
 */
+ (void)dc_SaveNewAppVersion:(NSString *)version;


@end
