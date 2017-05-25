//
//  DCCustomViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCCustomViewController.h"

#import "DCConsts.h"
#import "DCShopItemView.h"
#import "UIView+DCExtension.h"
#import "UIViewController+XWTransition.h"

#import <Masonry.h>

#define currentScreenW ScreenW * 0.8

@interface DCCustomViewController ()<ShopItemViewDelegate>

/* 商品种类选择屏幕 */
@property (weak ,nonatomic) UIView *shopScreenView;
/** 品牌 */
@property (nonatomic ,weak) DCShopItemView *attributeViewBrand;
/** 排序 */
@property (nonatomic ,weak) DCShopItemView *attributeViewSort;


@end

@implementation DCCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpShopsScreenView];
    
    [self setUpShareAlterView];
    
    [self setUpBottomView];
    
    [self setUpTagView];
}


- (void)setUpTagView {
    UIView *topW = [[UIView alloc]initWithFrame:CGRectMake(0, 0, currentScreenW, 20)];
    topW.backgroundColor = [UIColor whiteColor];
    [self.shopScreenView addSubview:topW];
    UIFont *PfFont = [UIFont systemFontOfSize:14];

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, currentScreenW, 1)];
    [self.shopScreenView addSubview:scrollView];
    
    DCShopItemView *attributeViewBrand = [DCShopItemView attributeViewWithTitle:@"全部品牌" titleFont:PfFont titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:@[@"苹果",@"三星",@"华为",@"小米",@"魅族",@"努比亚",@"OPPO"] viewWidth:currentScreenW];
    self.attributeViewBrand = attributeViewBrand;
    

    NSArray *sortData = @[@"默认排序",@"价格由低到高",@"价格由高到低",@"销量高到低",@"销量低到高"];
    DCShopItemView *attributeViewSort = [DCShopItemView attributeViewWithTitle:@"全部排序" titleFont:PfFont titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:sortData viewWidth:currentScreenW];
    self.attributeViewSort = attributeViewSort;
    
    attributeViewBrand.dc_y = 0;
    attributeViewSort.dc_y = CGRectGetMaxY(attributeViewBrand.frame) + 10 * 2;
    
    // 设置代理
    attributeViewBrand.ShopItem_delegate = self;
    attributeViewSort.ShopItem_delegate = self;
    
    // 添加到scrollview上
    [scrollView addSubview:attributeViewBrand];
    [scrollView addSubview:attributeViewSort];
    scrollView.contentSize = (CGSize){0,attributeViewSort.dc_bottom};
    
    // 添加scrollview到当前view上
    [self.shopScreenView addSubview:scrollView];
    // 通过动画设置scrollview的高度, 也可以一开始就设置好
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        scrollView.dc_height += [UIScreen mainScreen].bounds.size.height -  70;
    } completion:nil];
}

#pragma mark - AttributeViewDelegate
- (void)ShopItem_View:(DCShopItemView *)view didClickBtn:(UIButton *)btn{
    NSString *title = btn.titleLabel.text;
    NSLog(@"%@",title);
    if ([view isEqual:self.attributeViewBrand]){
       NSArray *brandArray = @[@"苹果",@"三星",@"华为",@"小米",@"魅族",@"努比亚",@"OPPO"];
        for (NSInteger i = 0; i<brandArray.count; i++) {
            if ([brandArray[i] isEqualToString:title]) {
                NSLog(@"%zd  %@",i , brandArray[i]);
                _attributeViewBrandString = brandArray[i];
            }
    }
    }else{
        NSArray *sortData = @[@"默认排序",@"价格由低到高",@"价格由高到低",@"销量高到低",@"销量低到高"];
        for (NSInteger i = 0; i<sortData.count; i++) {
            if ([sortData[i] isEqualToString:title]) {
                NSLog(@"%zd  %@",i , sortData[i]);
                _attributeViewSortString = sortData[i];
            }
        }
    }

}

#pragma mark - 商品种类屏幕
- (void)setUpShopsScreenView
{
    UIView *shopScreenView = [[UIView alloc] init];
    [self.view addSubview:shopScreenView];
    shopScreenView.backgroundColor = DCRGBColor(247, 247, 247);

    _shopScreenView = shopScreenView;
    
    [shopScreenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(currentScreenW));
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view);
    }];
    
}
#pragma mark - 商品种类底部按钮View
- (void)setUpBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    [self.shopScreenView addSubview:bottomView];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.backgroundColor = [UIColor redColor];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.shopScreenView addSubview:sureButton];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(50));
        make.width.mas_equalTo(self.shopScreenView.mas_width);
        make.bottom.mas_equalTo(self.shopScreenView.mas_bottom);
    }];
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(bottomView.mas_width);
        make.right.mas_equalTo(bottomView.mas_right);
        make.height.mas_equalTo(bottomView.mas_height);
        make.bottom.mas_equalTo(bottomView.mas_bottom);
    }];
}

#pragma mark - 确定按钮点击
- (void)sureButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{//做需要的回调在这里实现
        !_sureButtonClickBlock ? :_sureButtonClickBlock(_attributeViewBrandString,_attributeViewSortString);
    }];
}

#pragma mark - 弹出弹框
- (void)setUpShareAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionLeft;
    __weak typeof(self)weakSelf = self;
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf selfViewBack];
    } edgeSpacing:80];
}

#pragma mark - 退出当前View
- (void)selfViewBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
