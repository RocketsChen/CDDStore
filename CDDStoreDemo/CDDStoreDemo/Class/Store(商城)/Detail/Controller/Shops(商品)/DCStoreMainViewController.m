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
/* 商品标题 */
@property (weak ,nonatomic) UILabel *showShopLabel;
/* 商品价格 */
@property (weak ,nonatomic) UILabel *showMoneyLabel;
/* 商品快递费 */
@property (weak, nonatomic) UILabel *expressageLabel;
/* 商品已售出量 */
@property (weak, nonatomic) UILabel *saleCountLabel;
/* 商品地点 */
@property (weak, nonatomic) UILabel *siteLabel;
/* 商品第二介绍 */
@property (weak, nonatomic) UILabel *secondtitleLabel;

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
    showShopLabel.text = _goods_title;
    showShopLabel.font = [UIFont systemFontOfSize:16];
    showShopLabel.numberOfLines = 0;
    [view addSubview:shopTitleView];
    _showShopLabel = showShopLabel;
    
    
    UIView *verticalPartingLine = [[UIView alloc] init];
    verticalPartingLine.backgroundColor = [self.view.backgroundColor colorWithAlphaComponent:0.5];
    [shopTitleView addSubview:verticalPartingLine];
    
    DCStoreButton *shareButton = [DCStoreButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"shareview"] forState:UIControlStateNormal];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [shareButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [shopTitleView addSubview:shareButton];

    UILabel *showMoneyLabel = [[UILabel alloc] init];
    showMoneyLabel.font = [UIFont systemFontOfSize:20];
    showMoneyLabel.textColor = [UIColor redColor];
    showMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",_shopPrice];
    [shopTitleView addSubview:showMoneyLabel];
    _showMoneyLabel = showMoneyLabel;
    
    shopTitleView.backgroundColor = [UIColor whiteColor];
    [shopTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view);
        make.width.mas_equalTo(view);
        [make.top.mas_equalTo(cycleScrollView.mas_bottom)setOffset:10];
        make.height.mas_equalTo(@(70));
    }];
    
    [showShopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(shopTitleView)setOffset:10];
        [make.right.mas_equalTo(shareButton)setOffset:-20];
        [make.top.mas_equalTo(shopTitleView)setOffset:0];
        make.height.mas_equalTo(@(50));
    }];
    
    [showMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(showShopLabel);
        [make.top.mas_equalTo(showShopLabel.mas_bottom)setOffset:0];
        make.width.mas_equalTo(showShopLabel);
    }];
    
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(view)setOffset:-10];
        [make.top.mas_equalTo(showShopLabel)setOffset:5];
        make.height.mas_equalTo(@(22));
        make.width.mas_equalTo(@(22));
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
        cell.expressageLabel.text = [NSString stringWithFormat:@"快递费: %@",_expressage];
        cell.saleCountLabel.text = [NSString stringWithFormat:@"销售 %@ 笔",_saleCount] ;
        cell.siteLabel.text = _site;
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
    itemVc.money = _shopPrice;
    itemVc.iconImage = _goodspics;
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
