//
//  AppDelegate.m
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "AppDelegate.h"
#import "JKDBModel.h"
#import "DCTabBarController.h"

#import "JPFPSStatus.h"
#import "RequestTool.h"
#import "NetworkUnit.h"
#import "DCAppVersionTool.h"
#import <SVProgressHUD.h>
#import "UIImageView+WebCache.h"

#import "DCNewFeatureViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setUpRootVC]; //跟控制器判断
    
    [self.window makeKeyAndVisible];
    
//    [self CDDMallVersionInformationFromPGY]; //蒲公英自动更新
    
#if defined(DEBUG)||defined(_DEBUG) //仅仅在模拟器上跑测试会显示FPS
    [[JPFPSStatus sharedInstance] open];
#endif
    
    [self setUpFixiOS11]; //适配IOS 11
    
    
    return YES;
}


#pragma mark - 根控制器
- (void)setUpRootVC
{
    if ([BUNDLE_VERSION isEqualToString:[DCAppVersionTool dc_GetLastOneAppVersion]]) {//判断是否当前版本号等于上一次储存版本号

        self.window.rootViewController = [[DCTabBarController alloc] init];
    }else{
        
        [DCAppVersionTool dc_SaveNewAppVersion:BUNDLE_VERSION]; //储存当前版本号

        // 设置窗口的根控制器
        DCNewFeatureViewController *dcFVc = [[DCNewFeatureViewController alloc] init];
        [dcFVc setUpFeatureAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selColor, BOOL *showSkip, BOOL *showPageCount) {
            
            *imageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
            *showPageCount = YES;
            *showSkip = YES;
        }];
        self.window.rootViewController = dcFVc;
    }
}

#pragma mark - 适配
- (void)setUpFixiOS11
{
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 当APP接收到内存警告的时候
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDWebImageManager sharedManager]cancelAll]; //取消所有下载
    [[SDWebImageManager sharedManager].imageCache clearMemory]; //立即清除缓存
}

#pragma mark - 蒲公英版本更新检测
- (void)CDDMallVersionInformationFromPGY
{
    NSDictionary *dict = @{
                          @"shortcut" : VERSION_Shortcut,  //应用页面地址后缀
                          @"_api_key" : [NSString stringWithFormat:@"%@",VERSION_API_KEY]
                          };
    
    [RequestTool requestWithType:POST URL:VERSION_HTTPS_SERVER parameter:dict successComplete:^(id responseObject) {
        
        if ([[responseObject valueForKey:@"code"] intValue] == 0) {
            NSLog(@"CDDMall请求成功 appVersion%@,appVersionNo%@",[[responseObject valueForKey:@"data"] valueForKey:@"appVersion"],[[responseObject valueForKey:@"data"] valueForKey:@"appVersionNo"]);
            
            NSString *newVersion = [[responseObject valueForKey:@"data"] valueForKey:@"appVersion"];
            NSString *newBiuld = [[responseObject valueForKey:@"data"] valueForKey:@"appVersionNo"]; //为@""之前未上传过版本
            NSString *beforeVersion = BIULD_VERSION;
            NSString *beforeBiuld = BUNDLE_VERSION;
            
            if ((![newVersion isEqualToString:beforeVersion] || ![newBiuld isEqualToString:beforeBiuld] ) && ![newBiuld isEqualToString:@""]){
                
                NSDictionary *dict = @{
                                       @"uKey" : VERSION_User_Key,
                                       @"_api_key" : [NSString stringWithFormat:@"%@",VERSION_API_KEY],
                                       @"aKey" : [[responseObject valueForKey:@"data"] valueForKey:@"appKey"]
                                       };
                
                [RequestTool requestWithType:POST URL:VERSION_HTTPS_INFO parameter:dict successComplete:^(id responseObject) {
                    
                    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                    alertWindow.rootViewController = [[UIViewController alloc] init];
                    alertWindow.windowLevel = UIWindowLevelAlert + 1;
                    [alertWindow makeKeyAndVisible];
                    
                    [DCSpeedy dc_SetUpAlterWithView:alertWindow.rootViewController Message:[NSString stringWithFormat:@"CDDMall有新版本，请前往更新\n更新内容：%@",[[responseObject valueForKey:@"data"] valueForKey:@"appUpdateDescription"]] Sure:^{
                        
                        //现在绑定
                        NSURL *url = [NSURL URLWithString:VERSION_Itms_Services];
                        [[UIApplication sharedApplication] openURL:url];
                        
                    } Cancel:nil];
                    
                } failureComplete:^(NSError *error) {
                    
                }];
            }
        }

    } failureComplete:^(NSError *error) {
        
        NSLog(@"蒲公英请求失败~");
        
    }];
}


@end
