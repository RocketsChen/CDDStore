//
//  DCStoreViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreViewController.h"

#import "DCStoreItem.h"
#import "DCStoreItemCell.h"

#import "DCConsts.h"
#import "UIView+DCExtension.h"

#import <Masonry.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <SDCycleScrollView.h>
#import <TXScrollLabelView.h>

static NSString *DCStoreItemCellID = @"DCStoreItemCell";

#define ScreenHNoNavi ([UIScreen mainScreen].bounds.size.height - 64 - 49)

@interface DCStoreViewController ()<UITableViewDelegate , UITableViewDataSource,SDCycleScrollViewDelegate,UISearchBarDelegate>
@property (nonatomic , strong) UITableView *tableView;
/* 数据 */
@property (strong , nonatomic)NSMutableArray<DCStoreItem *> *storeItem;

/* 小标题 */
@property (assign , nonatomic)NSString *scrollTitle;

/* 轮播图 */
@property (weak ,nonatomic)SDCycleScrollView *cycleScrollView;

@end

@implementation DCStoreViewController

#pragma mark - 懒加载
- (NSMutableArray<DCStoreItem *> *)storeItem
{
    if (!_storeItem) {
        _storeItem = [NSMutableArray array];
    }
    return _storeItem;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 59, 0);
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
    
    [self setUpHeaderView:@[@"mainHead",@"mainHead"] WithAdvertisement:@"如果觉得项目还行，请赏个Star！谢谢"];
    
    [self setUpTab];
    
    [self loadStoreDatas];

}

- (void)setUpHeaderView : (NSArray *)bannerImages WithAdvertisement : (NSString *)advertise{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenHNoNavi * 0.4 + 77)];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, ScreenHNoNavi * 0.4 - 20) imageURLStringsGroup:bannerImages];
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.autoScrollTimeInterval = 5.0;
    [view addSubview:cycleScrollView];
    _cycleScrollView = cycleScrollView;
    
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView.delegate = self;
    self.tableView.tableHeaderView = view;
    
    
    UIView *scrollLabelView = [[UIView alloc]init];
    scrollLabelView.backgroundColor = [UIColor whiteColor];
    [cycleScrollView addSubview:scrollLabelView];
    
    [scrollLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cycleScrollView.mas_left);
        make.right.mas_equalTo(cycleScrollView.mas_right);
        [make.top.mas_equalTo(cycleScrollView.mas_top)setOffset:cycleScrollView.dc_height];
        make.height.mas_equalTo(@(30));
    }];
    
    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"notice"];
    [scrollLabelView addSubview:image];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(scrollLabelView.mas_left)setOffset:10];
        make.centerY.mas_equalTo(scrollLabelView.mas_centerY);
        make.width.mas_equalTo(@(14));
        make.height.mas_equalTo(@(15));
    }];
    
    TXScrollLabelView *labelView = [TXScrollLabelView scrollWithTitle:advertise type:TXScrollLabelViewTypeFlipNoRepeat velocity:5.0 options:UIViewAnimationOptionCurveEaseInOut];
    labelView.frame = CGRectMake(20, 6, ScreenW - 15, 20);
    labelView.backgroundColor = [UIColor clearColor];
    labelView.font = [UIFont systemFontOfSize:12];
    labelView.scrollTitleColor = [UIColor blackColor];
    labelView.userInteractionEnabled = NO;
    [scrollLabelView addSubview:labelView];
    [labelView beginScrolling];
    
    //喇叭通知点击
    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:clickBtn];
    clickBtn.frame = CGRectMake(0, cycleScrollView.dc_bottom, ScreenW, 10 * 3);
    [clickBtn addTarget:self action:@selector(shopAdvertiseClick) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

#pragma mark - 点击了广告跳转
- (void)shopAdvertiseClick {
    
}


- (void)loadStoreDatas
{
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _storeItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCStoreItemCell *cell = [tableView dequeueReusableCellWithIdentifier:DCStoreItemCellID forIndexPath:indexPath];
    cell.storeItem = _storeItem[indexPath.row];
    
    return cell;
}

- (void)setUpTab
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"商城";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCStoreItemCell class]) bundle:nil] forCellReuseIdentifier:DCStoreItemCellID];
}

@end
