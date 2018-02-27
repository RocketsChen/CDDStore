//
//  Macros.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 Insect. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;


/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"
/*****************  屏幕适配  ******************/
#define iphone6p (ScreenH == 763)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

//全局背景色
#define DCBGColor RGB(245,245,245)

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"


#define TITLES @[@"发起聊天", @"添加好友", @"扫一扫"]
#define ICONS  @[@"mshop_message_gray",@"mshop_message_gray",@"mshop_message_gray"]


#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];
#define PFR9Font [UIFont fontWithName:PFR size:9];
#define PFR8Font [UIFont fontWithName:PFR size:8];

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define KEYWINDOW  [UIApplication sharedApplication].keyWindow

#define UserInfoData [DCUserInfo findAll].lastObject


//判断设备是否为iphoneX
#define DCIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//数组
#define GoodsRecommendArray  @[@"http://gfs5.gomein.net.cn/T1blDgB5CT1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1loYvBCZj1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1w5bvB7K_1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1w5bvB7K_1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1L.VvBCxv1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1joLvBKhT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1AoVvB7_v1RCvBVdK.jpg"]

#define GoodsHandheldImagesArray  @[@"http://gfs8.gomein.net.cn/T1LnWvBsAg1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1CLLvBQbv1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1CCx_B5CT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T17QxvB7b_1RCvBVdK.jpg",@"http://gfs8.gomein.net.cn/T17CWsBmKT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1nabsBCxT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T199_gBCDT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1H.VsBKZT1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1JRW_BmLT1RCvBVdK.jpg"]

#define GoodsBeautySilderImagesArray @[@"http://gfs8.gomein.net.cn/T1QtA_BXdT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1__ZvB7Aj1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1SZ__B5VT1RCvBVdK.jpg"]

#define GoodsHomeSilderImagesArray @[@"http://gfs5.gomein.net.cn/T1obZ_BmLT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1C3J_B5LT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1CwYjBCCT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1u8V_B4ET1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1zODgB5CT1RCvBVdK.jpg"]

#define GoodsFooterImagesArray @[@"http://gfs5.gomein.net.cn/T1vpK_BCZT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1cGK_BCZT1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1Kod_BCxT1RCvBVdK.jpg"]

#define GoodsNewWelfareImagesArray @[@"http://gfs6.gomein.net.cn/T1.iJvBXVT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T10_LvBjLv1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1ALVvBXZg1RCvBVdK.jpg"]


#define BeastBeautyShopArray @[@"http://gfs7.gomein.net.cn/T1xp_sB7KT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1Ao_sB7VT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T12md_B7YT1RCvBVdK.jpg"]

#define HomeBottomViewGIFImage @"http://gfs8.gomein.net.cn/T1RbW_BmdT1RCvBVdK.gif"

//URL
#define CDDWeiBo @"http://weibo.com/u/5605532343"

#define CDDJianShu01 @"http://www.jianshu.com/p/3f248b614bdc"
#define CDDJianShu02 @"http://www.jianshu.com/p/1b19028dc975"
#define CDDJianShu03 @"http://www.jianshu.com/p/cc92ea70addf"
#define CDDJianShu04 @"http://www.jianshu.com/p/d08ab02d219c"


/*****************  蒲公英更新  ******************/
//版本控制
#define VERSION_HTTPS_SERVER @"http://www.pgyer.com/apiv1/app/getAppKeyByShortcut"
//版本更新内容
#define VERSION_HTTPS_INFO @"http://www.pgyer.com/apiv1/app/view"
//蒲公英应用api_Key
#define VERSION_API_KEY @"e08ad9d9e8fb4dee72c44cb486be09c0"
//蒲公英应用User_Key
#define VERSION_User_Key @"eb79e5278779732ec8634c0c21d304ed"
//蒲公英应用页面地址后缀
#define VERSION_Shortcut @"Mall"
//蒲公英应用itms-services下载
#define VERSION_Itms_Services @"itms-services://?action=download-manifest&url=https%3A%2F%2Fwww.pgyer.com%2Fapiv1%2Fapp%2Fplist%3FaId%3Db15ba9b695d00c14e1361c24c1869a17%26_api_key%3De08ad9d9e8fb4dee72c44cb486be09c0"
//获取当前版本号
#define BUNDLE_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
//获取当前版本的biuld
#define BIULD_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//获取当前设备的UDID
#define DIV_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

#endif /* Macros_h */
