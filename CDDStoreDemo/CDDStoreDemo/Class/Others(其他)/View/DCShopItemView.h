//
//  DCShopItemView.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCShopItemView;

@protocol ShopItemViewDelegate<NSObject>

@optional
-(void)ShopItem_View:(DCShopItemView *)view didClickBtn:(UIButton *)btn;
@end

@interface DCShopItemView : UIView

@property(nonatomic,assign)id <ShopItemViewDelegate>ShopItem_delegate;

/**
 *  返回一个创建好的属性视图,并且带有标题.创建好之后必须设置视图的Y值.
 *
 *  @param texts 属性数组
 *
 *  @return attributeView
 */
+ (DCShopItemView *)attributeViewWithTitle:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)titleColor WithBtnBgColor:(UIColor *)bgColor titleNormalColor:(UIColor *)normalColor titleSelectColor:(UIColor *)selectColor WithButtonCornerRadius:(NSInteger)radius attributeTexts:(NSArray *)texts viewWidth:(CGFloat)viewWidth;


/**
 自定义按钮
 */
@property (nonatomic ,weak) UIButton *btn;


@end
