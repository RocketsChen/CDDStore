//
//  DCScanningViewController.h
//  CDDScanningCode
//
//  Created by 陈甸甸 on 2018/1/3.
//Copyright © 2018年 陈甸甸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCFlashButton.h"


@protocol DCScanBackDelegate <NSObject>


@optional

- (void)DCScanningSucessBackWithInfor:(NSString *)message;//协议方法

@end

@interface DCScanningViewController : UIViewController

/* 闪光灯按钮 */
@property (strong , nonatomic)DCFlashButton *flashButton;
/* 提示按钮 */
@property (strong , nonatomic)UILabel *tipLabel;

@property (nonatomic, weak) id<DCScanBackDelegate>scanDelegate;//代理属性


/**
 跳转到相册
 */
- (void)jumpPhotoAlbum;


/**
 打开闪关灯

 @param button 闪光灯按钮
 */
- (void)flashButtonClick:(UIButton *)button;

@end
