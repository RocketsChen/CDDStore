//
//  DCPagerController.h
//  CDDPagerController
//
//  Created by apple on 2017/9/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//



#import <UIKit/UIKit.h>

#import "DCPagerMacros.h"

@interface DCPagerController : UIViewController


/**
 根据角标，跳转到对应的控制器（viewWillAppear方法里实现）
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 字体缩放
 */
- (void)setUpTitleScale:(void(^)(CGFloat *titleScale))titleScaleBlock;

/**
 progress设置
 *topDistance            设置ScrollView距离顶部的间距
 *titleViewHeight        设置ScrollView的高度
 */
- (void)setUpTopTitleViewAttribute:(void(^)(CGFloat *topDistance, CGFloat *titleViewHeight))settingTopTitleViewBlock;

/**
 progress设置
 *progressLength        设置progress长度
 *progressHeight        设置progress高度
 */
- (void)setUpProgressAttribute:(void(^)(CGFloat *progressLength, CGFloat *progressHeight))settingProgressBlock;

/**
 初始化
 
 *titleScrollViewBgColor 标题背景色
 *norColor               标题字体未选中状态下颜色
 *selColor               标题字体选中状态下颜色
 *proColor               字体下方指示器颜色
 *titleFont              标题字体大小
 *titleButtonWidth       标题按钮的宽度
 *isShowPregressView     是否开启字体下方指示器
 *isOpenStretch          是否开启指示器拉伸效果
 *isOpenShade            是否开启字体渐变效果

 @param BaseSettingBlock 设置基本属性
 */
- (void)setUpDisplayStyle:(void(^)(UIColor **titleScrollViewBgColor,UIColor **norColor,UIColor **selColor,UIColor **proColor,UIFont **titleFont,CGFloat *titleButtonWidth,BOOL *isShowPregressView,BOOL *isOpenStretch,BOOL *isOpenShade))BaseSettingBlock;

/**
 刷新标题和整个界面，在调用之前，需要获取到所有的子控制器。
 */
- (void)setUpRefreshDisplay;

@end
