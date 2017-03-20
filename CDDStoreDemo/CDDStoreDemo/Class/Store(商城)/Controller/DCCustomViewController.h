//
//  DCCustomViewController.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCustomViewController : UIViewController

/* 品牌字段 */
@property (assign ,nonatomic) NSString *attributeViewBrandString;

/* 排序字段 */
@property (assign ,nonatomic) NSString *attributeViewSortString;

/** 点击回调 */
@property (nonatomic, copy) void(^sureButtonClickBlock)(NSString *attributeViewBrandString,NSString *attributeViewSortString);

@end
