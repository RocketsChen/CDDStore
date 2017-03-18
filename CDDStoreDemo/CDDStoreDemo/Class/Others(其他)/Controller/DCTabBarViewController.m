//
//  DCTabBarViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCTabBarViewController.h"
#import "DCNavigationController.h"
#import "DCStoreViewController.h"

@interface DCTabBarViewController ()

@end

@implementation DCTabBarViewController

#pragma mark - 设置tabBar字体格式
+(void)load
{
    UITabBarItem *titleItem = [UITabBarItem appearance];
    //正常
    NSMutableDictionary *normalDict = [NSMutableDictionary dictionary];
    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [titleItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    //选中
    NSMutableDictionary *selectedDict = [NSMutableDictionary dictionary];
    selectedDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [titleItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setUpAllChildView];
    //添加所有按钮内容
    [self setUpTabBarBtn];
    
}


#pragma mark - 添加所有按钮内容
-(void)setUpTabBarBtn
{
    DCNavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.image = [UIImage imageNamed:@"shopping"];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:@"shopping down"];
    
}

#pragma mark - 添加子控制器
-(void)setUpAllChildView
{
    //商城
    DCStoreViewController *storeVc = [[DCStoreViewController alloc] init];
    DCNavigationController *nav = [[DCNavigationController alloc]initWithRootViewController:storeVc];
    [self addChildViewController:nav];
    
}

@end
