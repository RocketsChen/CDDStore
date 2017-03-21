//
//  DCNavigationTabBar.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 声明一个Block的变量类型
 
 @param buttonIndex 页面的索引
 */
typedef void(^TabBarDidClickAtIndex)(NSInteger buttonIndex);

@interface DCNavigationTabBar : UIView

/**
 点击传递索引
 */
@property(nonatomic,copy)TabBarDidClickAtIndex didClickAtIndex;


/**
 标题
 */
-(instancetype)initWithTitles:(NSArray *)titles;

/**
 滑动至索引
 */
-(void)scrollToIndex:(NSInteger)index;

/**
 背景颜色
 */
@property(nonatomic,strong)UIColor *sliderBackgroundColor;

/**
 button标题颜色（正常）
 */
@property(nonatomic,strong)UIColor *buttonNormalTitleColor;

/**
 button标题颜色（选中）
 */
@property(nonatomic,strong)UIColor *buttonSelectedTileColor;



@end
