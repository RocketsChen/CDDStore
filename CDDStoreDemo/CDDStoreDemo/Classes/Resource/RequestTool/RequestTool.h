//
//  RequestTool.h
//  LeakDemo
//
//  Created by Insect on 2016/12/26.
//  Copyright © 2016年 Insect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

@interface RequestTool : NSObject

typedef NS_ENUM(NSInteger, requestType) {
    GET = 1,
    POST = 2,
};

+ (AFHTTPSessionManager *)tool;

/**
 不带进度的普通请求
 
 @param type 请求类型
 @param URL 请求 URL
 @param parameter 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestWithType:(requestType )type
                    URL:(NSString *)URL
              parameter:(NSDictionary *)parameter
        successComplete:(void(^)(id responseObject))success
        failureComplete:(void(^)(NSError *error))failure;

/**
 带进度的普通请求
 
 @param type 请求类型
 @param URL 请求 URL
 @param parameter 请求参数
 @param progess 请求进度
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestWithType:(requestType )type
                    URL:(NSString *)URL
              parameter:(NSDictionary *)parameter
               progress:(void(^)(NSProgress *progess))progess
        successComplete:(void(^)(id responseObject))success
        failureComplete:(void(^)(NSError *error))failure;

/**
 没有进度有本地缓存的请求
 
 @param type 请求类型
 @param URL 请求 URL
 @param parameter 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestCacheWithType:(requestType)type
                         URL:(NSString *)URL
                   parameter:(NSDictionary *)parameter
             successComplete:(void(^)(id responseObject))success
             failureComplete:(void(^)(NSError *error))failure;

/**
 有进度有本地缓存的请求
 
 @param type 请求类型
 @param URL 请求 URL
 @param parameter 请求参数
 @param progess 下载进度
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestCacheWithType:(requestType)type
                         URL:(NSString *)URL
                   parameter:(NSDictionary *)parameter
                    progress:(void(^)(NSProgress *progess))progess
             successComplete:(void(^)(id responseObject))success
             failureComplete:(void(^)(NSError *error))failure;

/**
 取消所有请求
 */
+ (void)cancelAllRequest;


/**
 取消单个特定请求
 
 @param type 请求类型
 @param URL 请求 URL
 @param parameter 请求参数
 @param success 成功回调
 @param failure 失败回调
 @return 返回一个 NSURLSessionDataTask 对象 用参数接受并使用[xxx cancel]即可以取消特定请求
 */
+ (NSURLSessionDataTask *)cancelSpecifiedRequestWithType:(requestType )type
                                                     URL:(NSString *)URL
                                               parameter:(NSDictionary *)
parameter
                                         successComplete:(void(^)(id responseObject))success
                                         failureComplete:(void(^)(NSError *error))failure;

@end
