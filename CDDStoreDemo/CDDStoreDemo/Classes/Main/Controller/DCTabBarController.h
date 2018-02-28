//
//  DCTabBarController.h
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger ,DCTabBarControllerType){
    DCTabBarControllerMeiXin = 0,  //美信
    DCTabBarControllerHome = 1, //首页
    DCTabBarControllerMediaList = 2,  //美媚榜
    DCTabBarControllerBeautyStore = 3, //美店
    DCTabBarControllerPerson = 4, //个人中心
};

@interface DCTabBarController : UITabBarController

/* 控制器type */
@property (assign , nonatomic)DCTabBarControllerType tabVcType;

@end
