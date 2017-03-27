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

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpAllChildView];
    
}


#pragma mark - 添加子控制器
-(void)setUpAllChildView
{
    //商城
    DCStoreViewController *indentVc = [[DCStoreViewController alloc]init];
    [self setUpOneViewController:indentVc WithImage:@"home_home_tab" WithSelImage:@"home_home_tab_s" WithTitle:@"商城"];
}


- (void)setUpOneViewController :(UIViewController *)Vc WithImage:(NSString *)image WithSelImage:(NSString *)selImage WithTitle:(NSString *)title{
    
    DCNavigationController *navC = [[DCNavigationController alloc]initWithRootViewController:Vc];
    Vc.tabBarItem.image = [UIImage imageNamed:image];
    Vc.tabBarItem.selectedImage = [UIImage imageNamed:selImage];
    Vc.tabBarItem.title = title;
    [self addChildViewController:navC];
}

@end
