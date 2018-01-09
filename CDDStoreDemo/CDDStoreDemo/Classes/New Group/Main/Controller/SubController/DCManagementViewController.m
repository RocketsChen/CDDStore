//
//  DCManagementViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/18.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCManagementViewController.h"

// Controllers
#import "DCReceivingAddressViewController.h" //收获地址

// Models

// Views
#import "DCUserMgCell.h"
#import "DCUserMgHeadView.h"
// Vendors

// Categories

// Others

@interface DCManagementViewController ()<UITableViewDelegate,UITableViewDataSource>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 头部View */
@property (strong , nonatomic)DCUserMgHeadView *headView;

/* 数组 */
@property (nonatomic, copy) NSArray *userMgItem;

@end

static NSString *const DCUserMgCellID = @"DCUserMgCell";

@implementation DCManagementViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.frame = CGRectMake(0, DCTopNavH, ScreenW, ScreenH - DCTopNavH);
        [self.view addSubview:_tableView];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCUserMgCell class]) bundle:nil] forCellReuseIdentifier:DCUserMgCellID];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];

    [self setUpHeadView];
}

#pragma mark - initialize
- (void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.title = @"账户管理";
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titleArray = @[@"会员俱乐部",@"收货地址",@"实名认证",@"账户安全"];
    NSArray *subTitleArray = @[@"",@"",@"未认证",@"安全认证：中"];
    self.userMgItem = [NSArray arrayWithObjects:titleArray,subTitleArray, nil];
}

#pragma mark - 头部View
- (void)setUpHeadView
{
    _headView = [DCUserMgHeadView dc_viewFromXib];
    _headView.frame = CGRectMake(0, 0, ScreenW, 190);
    self.tableView.tableHeaderView = _headView;
    _headView.headViewTouchBlock = ^{
        NSLog(@"点击了头部View");
    };
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableFooterView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 46;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.userMgItem.firstObject;
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCUserMgCell *cell = [tableView dequeueReusableCellWithIdentifier:DCUserMgCellID forIndexPath:indexPath];
    cell.titleContent = _userMgItem.firstObject[indexPath.row];
    cell.subTitleContent = _userMgItem.lastObject[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DCReceivingAddressViewController *dcRaVc = [DCReceivingAddressViewController new];
    [self.navigationController pushViewController:dcRaVc animated:YES];
}

@end
