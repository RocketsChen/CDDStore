//
//  AppDelegate.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "DCTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[[UIDevice currentDevice] systemVersion] intValue] > 9.0) {
        [self init3DTouchActionShow:YES]; //打开
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    DCTabBarViewController *nav = [[DCTabBarViewController alloc] init];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
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

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler
{
    if ([shortcutItem.type isEqualToString:@"store"])
    {
       //视图跳转
    }else if ([shortcutItem.type isEqualToString:@"myOrder"])
    {
       //视图跳转
    }
}

/**
 type 该item 唯一标识符
 localizedTitle ：标题
 localizedSubtitle：副标题
 icon：icon图标 可以使用系统类型 也可以使用自定义的图片
 userInfo：用户信息字典 自定义参数，完成具体功能需求
 */
-(void)init3DTouchActionShow:(BOOL)isShow
{
    UIApplication *application = [UIApplication sharedApplication];
    
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"home_home_tab"];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc]initWithType:@"store" localizedTitle:@"商城" localizedSubtitle:nil icon:icon1 userInfo:nil];
    
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"home_home_tab"];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc]initWithType:@"myOrder" localizedTitle:@"购物车" localizedSubtitle:nil icon:icon2 userInfo:nil];
    
    if (isShow) //显示
    {
        application.shortcutItems = @[item1,item2];   
    }else
    {
        application.shortcutItems = @[];
    }
}

@end
