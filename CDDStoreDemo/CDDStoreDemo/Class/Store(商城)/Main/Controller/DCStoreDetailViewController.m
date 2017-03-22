//
//  DCStoreDetailViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreDetailViewController.h"

#import "DCStoreItemSelectViewController.h"

#import "DCStoreMainViewController.h"
#import "DCStoreIntroduceViewController.h"
#import "DCStoreCommentViewController.h"

#import "DCConsts.h"
#import "DCStoreButton.h"
#import "UIView+WZLBadge.h"
#import "UIView+DCExtension.h"
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

#import "DCNavigationTabBar.h"

#import <Masonry.h>

@interface DCStoreDetailViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
/** 自定义导航条上面的View */
@property(nonatomic,strong)DCNavigationTabBar *navigationTabBar;

/** 自控制器数组 */
@property(nonatomic,strong)NSArray<UIViewController *> *subViewControllers;

/* 购物车按钮 */
@property (weak ,nonatomic) UIButton *markButton;
/* 收藏 */
@property (nonatomic , copy) NSString *collectionID;
/* 收藏 按钮 */
@property (weak ,nonatomic)DCStoreButton *collectbutton;

@end

@implementation DCStoreDetailViewController

#pragma mark - 懒加载
- (DCNavigationTabBar *)navigationTabBar
{
    if (!_navigationTabBar) {
        _navigationTabBar = [[DCNavigationTabBar alloc]initWithTitles:@[@"商品",@"详情",@"评价"]];
        
        __weak typeof(self) weakSelf = self;
        [self.navigationTabBar setDidClickAtIndex:^(NSInteger index){
            [weakSelf navigationDidSelectedControllerIndex:index];
        }];
    }
    return _navigationTabBar;
}

-(NSArray *)subViewControllers
{
    if (!_subViewControllers) {
        //创建子控制器
        DCStoreMainViewController *storeMainVc = [[DCStoreMainViewController alloc] init];
        storeMainVc.goodsid = _goodsid;
        storeMainVc.goodspics = _goodspics;
        
        DCStoreIntroduceViewController *storeIntroduceVc = [[DCStoreIntroduceViewController alloc] init];
        
        DCStoreCommentViewController *storeCommentVc = [[DCStoreCommentViewController alloc] init];
        
        self.subViewControllers = @[storeMainVc,storeIntroduceVc,storeCommentVc];
    }
    return _subViewControllers;
}

#pragma mark - 底部立即购买部，收藏等View
-(void)setUpBottonView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bottomView];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(ScreenW - 180, 0, 90, 55);
    addButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [addButton addTarget:self action:@selector(addShoppingCarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    addButton.backgroundColor = [UIColor redColor];
    [bottomView addSubview:addButton];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    buyButton.frame = CGRectMake(ScreenW - 90, 0, 90, 55);
    buyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [buyButton addTarget:self action:@selector(buyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    buyButton.backgroundColor = [UIColor orangeColor];
    [bottomView addSubview:buyButton];
    
    
    NSArray *imageNormalNames = @[@"comments on",@"collection_N",@"add shopping on"];
    NSArray *selectHightNames = @[@"comments",@"collection_S",@"add shopping"];
    NSArray *titleNames = @[@"客服",@"收藏",@"购物车"];
    
    CGFloat buttonW = (ScreenW - 190) / 3;
    CGFloat buttonH = 50;
    for (NSInteger i = 0; i < 3; i++) {
        
        DCStoreButton *button = [DCStoreButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitle:titleNames[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageNormalNames[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setImage:[UIImage imageNamed:selectHightNames[i]] forState:UIControlStateSelected];
        
        button.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        button.tag = i;
        
        if (button.tag == 1) {
            _collectbutton = button;
        }
        
        if (button.tag == 2) {//购物车数量提示
            UIButton *markButton = [UIButton buttonWithType:UIButtonTypeCustom];
            markButton.frame = CGRectMake(CGRectGetMaxX(button.imageView.frame), button.imageView.dc_y, 10, 10);
            [button addSubview:markButton];
            _markButton = markButton;
            [markButton showBadgeWithStyle:WBadgeStyleNumber value:2 animationType:WBadgeAnimTypeScale];  //购物车提示数
            markButton.badgeBgColor = [UIColor redColor];
            markButton.badgeTextColor = [UIColor whiteColor];
        }
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [bottomView addSubview:button];
        
    }
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(@(55));
    }];
    
    UIView *partingLine = [[UIView alloc] init];
    partingLine.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    [bottomView addSubview:partingLine];
    

    [partingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView);
        make.right.mas_equalTo(bottomView);
        make.bottom.mas_equalTo(bottomView);
        make.height.mas_equalTo(@(0.5));
    }];
}


#pragma mark - 立即购买按钮点击
- (void)buyButtonClick
{
//    [self ItemSelectionTransition];
}
#pragma mark - 加入购物车按钮点击
- (void)addShoppingCarButtonClick
{
//    [self ItemSelectionTransition];
}

#pragma mark - 弹出选择商品服务弹框
- (void)ItemSelectionTransition {
    
    XWDrawerAnimatorDirection direction = XWDrawerAnimatorDirectionBottom;
    CGFloat distance = 450; //基础服务窗口高度
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.toDuration = 0.5;
    animator.backDuration = 0.5;
    animator.flipEnable = YES;
    
    //点击当前界面返回
    __weak typeof(self)weakSelf = self;
    DCStoreItemSelectViewController *itemVc = [[DCStoreItemSelectViewController alloc] init];
    
    [self xw_presentViewController:itemVc withAnimator:animator];
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
    
}

#pragma 退出基础服务界面
- (void)selfAlterViewback{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 客服，收藏，购物车按钮点击
- (void)buttonClick:(DCStoreButton *)button
{
    
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.navigationTabBar;
    self.automaticallyAdjustsScrollViewInsets = NO; //这个必须要填写  不然会下移64哦！
    self.delegate = self;
    self.dataSource = self;
    [self setViewControllers:@[self.subViewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self setUpBottonView];
    
}

#pragma mark - <UIPageViewControllerDelegate>
/**
 在这两个方法中就是初始化和生成制定下一页的viewController
 */
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //控制器索引
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self.subViewControllers objectAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //控制器索引
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == NSNotFound || index == self.subViewControllers.count - 1) {
        return nil;
    }
    index++;
    return [self.subViewControllers objectAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.viewControllers[0];
    NSUInteger index = [self.subViewControllers indexOfObject:viewController];
    [self.navigationTabBar scrollToIndex:index];
    
}

#pragma mark - 点击控制器跳转
- (void)navigationDidSelectedControllerIndex:(NSInteger)index {
    [self setViewControllers:@[[self.subViewControllers objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

@end
