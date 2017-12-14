//
//  RequestTool.m
//  LeakDemo
//
//  Created by Insect on 2016/12/26.
//  Copyright © 2016年 Insect. All rights reserved.
//

#import "RequestTool.h"
#import "NetworkUnit.h"
#import "EGOCache.h"

@implementation RequestTool

static AFHTTPSessionManager *_manager;

+ (AFHTTPSessionManager *)tool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [AFHTTPSessionManager manager];
    });
    return _manager;
}

+ (AFHTTPSessionManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript" , @"text/plain" ,@"text/html",@"application/xml",@"image/jpeg",nil];
//        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 5.0f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//         [_manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //***************** HTTPS 设置 *****************************//
        // 设置非校验证书模式
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        // 客户端是否信任非法证书
        _manager.securityPolicy.allowInvalidCertificates = YES;
        // 是否在证书域字段中验证域名
        _manager.securityPolicy.validatesDomainName = NO;
    });
    return _manager;
}

+ (void)requestWithType:(requestType)type
                    URL:(NSString *)URL
              parameter:(NSDictionary *)parameter
        successComplete:(void(^)(id responseObject))success
        failureComplete:(void(^)(NSError *error))failure {
    
    _manager = [self sharedManager];
    if (![[NetworkUnit getInternetStatus] isEqualToString:@"notReachable"]) { // 有网络
        if (type == 1) { // GET 请求
            
            [_manager GET:URL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                
                !success ? : success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                
                if (error.code == NSURLErrorCancelled)  return ;
                NSLog(@"%@",error);
                !failure ? : failure(error);
            }];
        }else if (type == 2){ // POST 请求
            
            [_manager POST:URL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                
                !success ? : success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                
                if (error.code == NSURLErrorCancelled)  return ;
                NSLog(@"%@",error);
                !failure ? : failure(error);
            }];
        }else {
            NSLog(@"未选择请求类型");
            return;
        }
    }else { // 没有网络
        return;
    }
}

+ (void)requestWithType:(requestType )type
                    URL:(NSString *)URL
              parameter:(NSDictionary *)parameter
               progress:(void(^)(NSProgress *progess))progess
        successComplete:(void(^)(id responseObject))success
        failureComplete:(void(^)(NSError *error))failure {
    
    _manager = [self sharedManager];
    
    if (![[NetworkUnit getInternetStatus] isEqualToString:@"notReachable"]) { // 有网络
        if (type == 1) { // GET 请求
            
            [_manager GET:URL parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress){
                
                !progess ? : progess(downloadProgress);
            }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                
                !success ? : success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                
                if (error.code == NSURLErrorCancelled)  return ;
                NSLog(@"%@",error);
                !failure ? : failure(error);
            }];
        }else if (type == 2){ // POST 请求
            
            [_manager POST:URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress){
                
                !progess ? : progess(uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                
                !success ? : success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                
                if (error.code == NSURLErrorCancelled)  return ;
                NSLog(@"%@",error);
                !failure ? : failure(error);
            }];
        }else {
            NSLog(@"未选择请求类型");
            return;
        }
    }else { // 没有网络
        return;
    }
}

+ (void)requestCacheWithType:(requestType)type
                         URL:(NSString *)URL
                   parameter:(NSDictionary *)parameter
             successComplete:(void(^)(id responseObject))success
             failureComplete:(void(^)(NSError *error))failure {
    
    _manager = [self sharedManager];
    
    if (![[NetworkUnit getInternetStatus] isEqualToString:@"notReachable"]) { // 有网络
        if (type == 1) { // GET 请求
            
            [_manager GET:URL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                
                if (responseObject) { // 缓存到本地
                    [[EGOCache globalCache] setObject:responseObject forKey:URL];
                }
                else { // 从缓存中取
                    responseObject = [[EGOCache globalCache] objectForKey:URL];
                    if (!responseObject) { // 缓存中没有，直接返回
                        return;
                    }
                }
                
                !success ? : success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                
                if (error.code == NSURLErrorCancelled)  return ;
                NSLog(@"%@",error);
                id responseObject = [[EGOCache globalCache] objectForKey:URL];
                if (success) {
                    if (responseObject) { // 请求失败时，如果缓存中有数据也从缓存中取，没有则返回错误信息
                        success(responseObject);
                    }else {
                        !failure ? : failure(error);
                    }
                }
            }];
            
        }else if (type == 2) { // POST 请求
            
            [_manager POST:URL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                
                if (responseObject) { // 缓存到本地
                    [[EGOCache globalCache] setObject:responseObject forKey:URL];
                }
                else { // 从缓存中取
                    responseObject = [[EGOCache globalCache] objectForKey:URL];
                    if (!responseObject) { // 缓存中没有，直接返回
                        return;
                    }
                }
                
                !success ? : success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                
                if (error.code == NSURLErrorCancelled)  return ;
                NSLog(@"%@",error);
                id responseObject = [[EGOCache globalCache] objectForKey:URL];
                if (success) {
                    if (responseObject) { // 请求失败时，如果缓存中有数据也从缓存中取，没有则返回错误信息
                        success(responseObject);
                    }else {
                        !failure ? : failure(error);
                    }
                }
            }];
        }else {
            NSLog(@"未选择请求类型");
            return;
        }
    }else { // 没有网络从本地缓存中取
        id responseObject = [[EGOCache globalCache] objectForKey:URL];
        if (success) {
            if (responseObject) { // 有本地缓存
                success(responseObject);
            }else { // 本地没有缓存
                return;
            }
        }
    }
}

+ (void)requestCacheWithType:(requestType)type
                         URL:(NSString *)URL
                   parameter:(NSDictionary *)parameter
                    progress:(void(^)(NSProgress *progess))progess
             successComplete:(void(^)(id responseObject))success
             failureComplete:(void(^)(NSError *error))failure {
    
    _manager = [self sharedManager];
    
    if (![[NetworkUnit getInternetStatus] isEqualToString:@"notReachable"]) { // 有网络
        if (type == 1) { // GET 请求
            
            [_manager GET:URL parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress){
                
                !progess ? : progess(downloadProgress);
            }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                
                if (responseObject) { // 缓存到本地
                    [[EGOCache globalCache] setObject:responseObject forKey:URL];
                }
                else { // 从缓存中取
                    responseObject = [[EGOCache globalCache] objectForKey:URL];
                    if (!responseObject) { // 缓存中没有，直接返回
                        return;
                    }
                }
                
                !success ? : success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                
                if (error.code == NSURLErrorCancelled)  return ;
                NSLog(@"%@",error);
                id responseObject = [[EGOCache globalCache] objectForKey:URL];
                if (success) {
                    if (responseObject) { // 请求失败时，如果缓存中有数据也从缓存中取，没有则返回错误信息
                        success(responseObject);
                    }else {
                        !failure ? : failure(error);
                    }
                }
            }];
            
        }else if (type == 2) { // POST 请求
            
            [_manager POST:URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress){
                
                !progess ? : progess(uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                
                if (responseObject) { // 缓存到本地
                    [[EGOCache globalCache] setObject:responseObject forKey:URL];
                }
                else { // 从缓存中取
                    responseObject = [[EGOCache globalCache] objectForKey:URL];
                    if (!responseObject) { // 缓存中没有，直接返回
                        return;
                    }
                }
                
                !success ? : success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                
                if (error.code == NSURLErrorCancelled)  return ;
                NSLog(@"%@",error);
                id responseObject = [[EGOCache globalCache] objectForKey:URL];
                if (success) {
                    if (responseObject) { // 请求失败时，如果缓存中有数据也从缓存中取，没有则返回错误信息
                        success(responseObject);
                    }else {
                        !failure ? : failure(error);
                    }
                }
            }];
        }else {
            NSLog(@"未选择请求类型");
            return;
        }
    }else { // 没有网络从本地缓存中取
        id responseObject = [[EGOCache globalCache] objectForKey:URL];
        if (success) {
            if (responseObject) { // 有本地缓存
                success(responseObject);
            }else { // 本地没有缓存
                return;
            }
        }
    }
}

+ (void)cancelAllRequest {
    
    [[self sharedManager].tasks makeObjectsPerformSelector:@selector(cancel)];
}

+ (NSURLSessionDataTask *)cancelSpecifiedRequestWithType:(requestType )type
                                                     URL:(NSString *)URL
                                               parameter:(NSDictionary *)
parameter
                                         successComplete:(void(^)(id responseObject))success
                                         failureComplete:(void(^)(NSError *error))failure {
    
    _manager = [self sharedManager];
    if (type == 1) {
        
        NSURLSessionDataTask *taskID = [_manager GET:URL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            !success ? : success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            
            !failure ? : failure(error);
        }];
        return taskID;
    }else if (type == 2){
        
        NSURLSessionDataTask *taskID = [_manager POST:URL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            !success ? : success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            
            if (error.code == NSURLErrorCancelled)  return ;
            !failure ? : failure(error);
        }];
        return taskID;
    }else {
        NSLog(@"未选择请求类型");
        return nil;
    }
}

@end
