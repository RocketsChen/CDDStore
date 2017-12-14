//
//  DCObjManager.h
//  CDDKit
//
//  Created by apple on 2017/10/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCObjManager : NSObject

#pragma 把对象归档存到沙盒里
+(void)dc_saveObject:(id)object byFileName:(NSString*)fileName;

#pragma 通过文件名从沙盒中找到归档的对象
+(id)dc_getObjectByFileName:(NSString*)fileName;

#pragma 根据文件名删除沙盒中的 plist 文件
+(void)dc_removeFileByFileName:(NSString*)fileName;

#pragma 存储用户偏好设置 到 NSUserDefults
+(void)dc_saveUserData:(id)data forKey:(NSString*)key;

#pragma 读取用户偏好设置
+(id)dc_readUserDataForKey:(NSString*)key;

#pragma 删除用户偏好设置
+(void)dc_removeUserDataForkey:(NSString*)key;

@end
