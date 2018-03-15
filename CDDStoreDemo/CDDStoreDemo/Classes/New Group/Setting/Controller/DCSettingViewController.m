//
//  DCSettingViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/8.
//Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "DCSettingViewController.h"

// Controllers
#import "DCReceivingAddressViewController.h" //收获地址
#import "DCLoginViewController.h" //登录
// Models

// Views
#import "DCUserMgCell.h"
#import "DCUserMgHeadView.h"
// Vendors
#import <SVProgressHUD.h>
#import "UIView+Toast.h"
// Categories

// Others

@interface DCSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 头部View */
@property (strong , nonatomic)DCUserMgHeadView *headView;

/* 数组 */
@property (nonatomic, copy) NSArray *userMgItem;

@end

static NSString *const DCUserMgCellID = @"DCUserMgCell";

@implementation DCSettingViewController

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
    
    [self setUpLoginOff];
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


#pragma mark - 退出登录
- (void)setUpLoginOff
{
    UIView *footerView = [UIView new];
    
    UIButton *loginOffButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOffButton setTitle:@"退出登录" forState:0];
    loginOffButton.backgroundColor = RGB(235, 103, 98);
    loginOffButton.frame = CGRectMake(15, 35, ScreenW - 30, 45);
    [loginOffButton addTarget:self action:@selector(loginOffClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:loginOffButton];
    [DCSpeedy dc_setUpBezierPathCircularLayerWithControl:loginOffButton size:CGSizeMake(DCMargin, DCMargin)];
    footerView.dc_height = 80;
    self.tableView.tableFooterView = footerView;
}


#pragma mark - 退出登录
- (void)loginOffClick
{
    WEAKSELF
    [DCSpeedy dc_SetUpAlterWithView:self Message:@"是否确定退出登录" Sure:^{
        [DCObjManager dc_removeUserDataForkey:@"isLogin"];
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakSelf.view makeToast:@"退出登录成功" duration:0.5 position:CSToastPositionCenter];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //先跳出登录界面，在返回RootVC
                
                DCLoginViewController *dcLoginVc = [DCLoginViewController new];
                [weakSelf presentViewController:dcLoginVc animated:YES completion:^{
                    [[NSNotificationCenter defaultCenter]postNotificationName:LOGINOFFSELECTCENTERINDEX object:nil]; //退出登录
                }];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            });
        });
    } Cancel:nil];
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

