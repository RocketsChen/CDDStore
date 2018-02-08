
//
//  DCMyCenterViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/5.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCMyCenterViewController.h"

// Controllers
#import "DCManagementViewController.h" //账户管理
#import "DCGMScanViewController.h"  //扫一扫
#import "DCSettingViewController.h" //设置
// Models
#import "DCGridItem.h"
// Views
                               //顶部和头部View
#import "DCCenterTopToolView.h"
#import "DCMyCenterHeaderView.h"
                               //四组Cell
#import "DCCenterItemCell.h"
#import "DCCenterServiceCell.h"
#import "DCCenterBeaShopCell.h"
#import "DCCenterBackCell.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface DCMyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

/* headView */
@property (strong , nonatomic)DCMyCenterHeaderView *headView;
/* 头部背景图片 */
@property (nonatomic, strong) UIImageView *headerBgImageView;
/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 顶部Nva */
@property (strong , nonatomic)DCCenterTopToolView *topToolView;

/* 服务数据 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *serviceItem;
@end

static NSString *const DCCenterItemCellID = @"DCCenterItemCell";
static NSString *const DCCenterServiceCellID = @"DCCenterServiceCell";
static NSString *const DCCenterBeaShopCellID = @"DCCenterBeaShopCell";
static NSString *const DCCenterBackCellID = @"DCCenterBackCell";

@implementation DCMyCenterViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - DCBottomTabH);
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[DCCenterItemCell class] forCellReuseIdentifier:DCCenterItemCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCCenterServiceCell class]) bundle:nil] forCellReuseIdentifier:DCCenterServiceCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCCenterBeaShopCell class]) bundle:nil] forCellReuseIdentifier:DCCenterBeaShopCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCCenterBackCell class]) bundle:nil] forCellReuseIdentifier:DCCenterBackCellID];
        
    }
    return _tableView;
}

- (UIImageView *)headerBgImageView{
    if (!_headerBgImageView) {
        _headerBgImageView = [[UIImageView alloc] init];
        NSInteger armNum = [DCSpeedy dc_GetRandomNumber:1 to:9];
        [_headerBgImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mine_main_bg_%zd",armNum]]];
        [_headerBgImageView setBackgroundColor:[UIColor greenColor]];
        [_headerBgImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_headerBgImageView setClipsToBounds:YES];
    }
    return _headerBgImageView;
}

- (DCMyCenterHeaderView *)headView
{
    if (!_headView) {
        _headView = [DCMyCenterHeaderView dc_viewFromXib];
        _headView.frame =  CGRectMake(0, 0, ScreenW, 200);
    }
    return _headView;
}


- (NSMutableArray<DCGridItem *> *)serviceItem
{
    if (!_serviceItem) {
        _serviceItem = [NSMutableArray array];
    }
    return _serviceItem;
}

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpData];

    [self setUpNavTopView];
    
    [self setUpHeaderCenterView];
}

#pragma mark - 获取数据
- (void)setUpData
{
    _serviceItem = [DCGridItem mj_objectArrayWithFilename:@"MyServiceFlow.plist"];
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[DCCenterTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    WEAKSELF
    _topToolView.leftItemClickBlock = ^{ //点击了扫描
        DCGMScanViewController *dcGMvC = [DCGMScanViewController new];
        [weakSelf.navigationController pushViewController:dcGMvC animated:YES];
    };
    _topToolView.rightItemClickBlock = ^{ //点击设置
        DCSettingViewController *dcSetVc = [DCSettingViewController new];
        [weakSelf.navigationController pushViewController:dcSetVc animated:YES];
    };
    
    [self.view addSubview:_topToolView];
    
}


#pragma mark - initialize
- (void)setUpBase {
    
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.tableFooterView = [UIView new]; //去除多余分割线
}

#pragma mark - 初始化头部
- (void)setUpHeaderCenterView{
    
    self.tableView.tableHeaderView = self.headView;
    self.headerBgImageView.frame = self.headView.bounds;
    [self.headView insertSubview:self.headerBgImageView atIndex:0]; //将背景图片放到最底层
    
    WEAKSELF
    self.headView.headClickBlock = ^{
        DCManagementViewController *dcMaVc = [DCManagementViewController new];
        [weakSelf.navigationController pushViewController:dcMaVc animated:YES];
    };
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cusCell = [UITableViewCell new];
    if (indexPath.section == 0) {
        DCCenterItemCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterItemCellID forIndexPath:indexPath];
        cusCell = cell;
    }else if(indexPath.section == 1){
        DCCenterServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterServiceCellID forIndexPath:indexPath];
        cell.serviceItemArray = [NSMutableArray arrayWithArray:_serviceItem];
        cusCell = cell;
    }else if (indexPath.section == 2){
        DCCenterBeaShopCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterBeaShopCellID forIndexPath:indexPath];
        cusCell = cell;
    }else if (indexPath.section == 3){
        DCCenterBackCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterBackCellID forIndexPath:indexPath];
        cusCell = cell;
    }
    
    return cusCell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {//待付款Item组
//        return 300;
        return 180;
    }else if (indexPath.section == 1){
        return 215;
    }else if (indexPath.section == 2){
        return 280;
    }else if (indexPath.section == 3){
        return 200;
    }
    return 0;
}

#pragma mark - 滚动tableview 完毕之后
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;
    
    _topToolView.backgroundColor = (scrollView.contentOffset.y > 64) ? RGB(0, 0, 0) : [UIColor clearColor];
    
    //图片高度
    CGFloat imageHeight = self.headView.dc_height;
    //图片宽度
    CGFloat imageWidth = ScreenW;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    //上移
    if (imageOffsetY < 0) {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        self.headerBgImageView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
}



@end
