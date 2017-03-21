//
//  DCStoreMainViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreMainViewController.h"
#import "DCStoreItemSelectViewController.h"
#import "DCBaseViewController.h"

#import "DCAdExCell.h"
#import "DCIntroduceSelectCell.h"

#import "DCConsts.h"
#import "DCStoreButton.h"
#import "UIView+YKCExtension.h"
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

#import <Masonry.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <SDCycleScrollView.h>
#import <UIImageView+WebCache.h>

@interface DCStoreMainViewController ()<UITableViewDelegate , UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic , strong) UITableView *tableView;


@end

static NSString *const DCAdExCellID = @"DCAdExCell";
static NSString *const DCIntroduceSelectCellID = @"DCIntroduceSelectCell";

@implementation DCStoreMainViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 55) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTab];
    
    NSArray *imageArray = @[@"shopImage01",@"shopImage02",@"shopImage03"];
    [self setUpHeadShopsView:imageArray];
    
    [self setUpNote];
}

#pragma mark - 点击立即购买通知
- (void)setUpNote
{

}

- (void)setUpTab
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCAdExCell class]) bundle:nil] forCellReuseIdentifier:DCAdExCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCIntroduceSelectCell class]) bundle:nil] forCellReuseIdentifier:DCIntroduceSelectCellID];
}

#pragma mark - 创建商品头部视图
- (void)setUpHeadShopsView:(NSArray *)bannerImages
{
    // 网络加载图片的轮播器
    CGFloat  headPicH = (iphone4) ? ScreenHNoNavi * 0.64 : (iphone5) ? ScreenHNoNavi * 0.63 : (iphone6) ? ScreenHNoNavi * 0.62 : ScreenHNoNavi * 0.60;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, headPicH + 80)];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, headPicH) imageURLStringsGroup:bannerImages];
    cycleScrollView.backgroundColor = [UIColor whiteColor];
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit; //图片模式
    cycleScrollView.autoScrollTimeInterval = 5.0;
    [view addSubview:cycleScrollView];
    cycleScrollView.currentPageDotColor = [UIColor redColor];
    cycleScrollView.pageDotColor = [UIColor whiteColor];
    
    
    UIView *shopTitleView = [[UIView alloc] init];
    
    UILabel *showShopLabel = [[UILabel alloc] init];
    [shopTitleView addSubview:showShopLabel];
    showShopLabel.font = [UIFont systemFontOfSize:16];
    showShopLabel.numberOfLines = 0;
    [view addSubview:shopTitleView];
    _showShopLabel = showShopLabel;
    
    
    UIView *verticalPartingLine = [[UIView alloc] init];
    verticalPartingLine.backgroundColor = [self.view.backgroundColor colorWithAlphaComponent:0.5];
    [shopTitleView addSubview:verticalPartingLine];
    
    DCStoreButton *shareButton = [DCStoreButton buttonWithType:UIButtonTypeCustom];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [shareButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [shopTitleView addSubview:shareButton];
    
    UIButton *bigShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopTitleView addSubview:bigShareButton];
    
    UILabel *showMoneyLabel = [[UILabel alloc] init];
    showMoneyLabel.font = [UIFont systemFontOfSize:20];
    showMoneyLabel.textColor = [UIColor redColor];
    [shopTitleView addSubview:showMoneyLabel];
    _showMoneyLabel = showMoneyLabel;
    
    [shopTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view);
        make.width.mas_equalTo(view);
        make.bottom.mas_equalTo(view);
        make.height.mas_equalTo(@(50));
    }];
    
    [showShopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(shopTitleView)setOffset:10];
        [make.right.mas_equalTo(shareButton)setOffset:-10];
        [make.top.mas_equalTo(shopTitleView)setOffset:10];
        make.height.mas_equalTo(@(50));
    }];
    
    [showMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(showShopLabel);
        [make.top.mas_equalTo(showShopLabel)setOffset: - 10];
        make.width.mas_equalTo(showShopLabel);
    }];
    
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(shopTitleView)setOffset:-(5 + 22)];
        make.top.mas_equalTo(showShopLabel);
        make.height.mas_equalTo(@(22));
        make.width.mas_equalTo(@(22));
    }];

    [bigShareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(shopTitleView)setOffset:-10];
        [make.top.mas_equalTo(showShopLabel)setOffset:10];
        make.height.mas_equalTo(@(50));
        make.width.mas_equalTo(@(50));
    }];
    
    self.tableView.tableHeaderView = view;
}
#pragma 退出分享界面
- (void)selfAlterViewback{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DCAdExCell *cell = [tableView dequeueReusableCellWithIdentifier:DCAdExCellID forIndexPath:indexPath];
        _expressageLabel  = cell.expressageLabel;
        _saleCountLabel = cell.saleCountLabel;
        _siteLabel = cell.siteLabel;
        return cell;
        
    }else {
        
        DCIntroduceSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:DCIntroduceSelectCellID forIndexPath:indexPath];
        NSArray *titles = @[@"门店自提，品质保证，售后保障，急速发货",@"请选择 网络类型 机身颜色 套餐类型",@"满200元享包邮；不包邮地区：港澳台及海外"];
        cell.contentLabel.text = titles[indexPath.row - 1];
        cell.markButton.layer.borderColor = [[UIColor redColor] CGColor];
        cell.markButton.layer.borderWidth = 1.5f;
        cell.markButton.layer.cornerRadius = 8.0;
        cell.markButton.layer.masksToBounds = YES;
        cell.canClickButton.hidden = YES;
        [cell.markButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cell.markButton sizeToFit];
        if (indexPath.row != 3) {
            [cell.markButton removeFromSuperview];
            cell.canClickButton.hidden = NO;
        }
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self BaseServicesTransition];
    }else if (indexPath.row == 2){
//        [self ItemSelectionTransition];
    }else if (indexPath.row == 3) {
        NSLog(@"满200");
    }return;
}

#pragma mark - 弹出基础服务弹框
- (void)BaseServicesTransition {
    
    XWDrawerAnimatorDirection direction = XWDrawerAnimatorDirectionBottom;
    CGFloat distance = 450; //基础服务窗口高度
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.toDuration = 0.5;
    animator.backDuration = 0.5;
    animator.flipEnable = YES;
    
    //点击当前界面返回
    DCBaseViewController *baseServicesVc = [[DCBaseViewController alloc] init];
    [self xw_presentViewController:baseServicesVc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
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
    DCStoreItemSelectViewController *itemVc = [[DCStoreItemSelectViewController alloc] init];
    itemVc.stock = _stockStr;
    itemVc.goodsid = _goodsid;
    itemVc.money = @"12312";
    itemVc.iconImage = @"shopImage01";
    [self xw_presentViewController:itemVc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
    
}

#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (iphone4) ? ScreenH * 0.08 : (iphone5) ? ScreenH * 0.075 : (iphone6) ? ScreenH * 0.07 : ScreenH * 0.065;
}

#pragma mark - interactivePopGestureRecognizer
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

@end
