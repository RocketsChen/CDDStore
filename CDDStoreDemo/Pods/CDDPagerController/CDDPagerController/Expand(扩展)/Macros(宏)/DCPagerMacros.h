//
//  DCPagerMacros.h
//  CDDPagerController
//
//  Created by apple on 2017/9/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#ifndef DCPagerMacros_h
#define DCPagerMacros_h


#define DIV_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

/** 默认标题字体 */
#define DCTitleNorFont [UIFont systemFontOfSize:15]

/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define RandColor RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))


#endif /* DCPagerMacros_h */
