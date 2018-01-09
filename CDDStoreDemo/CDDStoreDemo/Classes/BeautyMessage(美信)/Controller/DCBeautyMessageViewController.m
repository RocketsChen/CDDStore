//
//  DCBeautyMessageViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/21.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBeautyMessageViewController.h"

// Controllers
#import "DCLoginMeViewController.h"
// Models

// Views

// Vendors

// Categories

// Others

@interface DCBeautyMessageViewController ()



@end

@implementation DCBeautyMessageViewController

#pragma mark - LazyLoad
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DCBGColor;
    self.navigationItem.title = @"美信";
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if ([[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"12"]) {
        
        DCLoginMeViewController *dcLoginVc = [DCLoginMeViewController new];
        [self presentViewController:dcLoginVc animated:YES completion:nil];
        
    }else{
        [DCSpeedy dc_SetUpAlterWithView:self Message:@"小圆点需要为您改变为12么" Sure:^{
            
            [DCObjManager dc_saveUserData:@"12" forKey:@"isLogin"]; //暂时以登录记录字段相关联，后续会新建字段
            [[NSNotificationCenter defaultCenter]postNotificationName:DCMESSAGECOUNTCHANGE object:nil];
            
        } Cancel:nil];
    }

}

@end
