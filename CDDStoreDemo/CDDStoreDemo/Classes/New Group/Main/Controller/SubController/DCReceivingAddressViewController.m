//
//  DCReceivingAddressViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/18.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCReceivingAddressViewController.h"

// Controllers
#import "DCNewAdressViewController.h" //新增地址
// Models
#import "DCAdressItem.h"
#import "DCAdressDateBase.h"
// Views
#import "DCUserAdressCell.h"
#import "DCUpDownButton.h"
// Vendors
#import <SVProgressHUD.h>
#import "UIView+Toast.h"
// Categories

// Others

@interface DCReceivingAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
/* 暂无收获提示 */
@property (strong , nonatomic)DCUpDownButton *bgTipButton;

/* tableView */
@property (strong , nonatomic)UITableView *tableView;

/* 地址信息 */
@property (strong , nonatomic)NSMutableArray<DCAdressItem *> *adItem;


@end

static NSString *const DCUserAdressCellID = @"DCUserAdressCell";

@implementation DCReceivingAddressViewController

#pragma mark - LazyLoad

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCUserAdressCell class]) bundle:nil] forCellReuseIdentifier:DCUserAdressCellID];
        
        _tableView.frame = CGRectMake(0, DCTopNavH, ScreenW, ScreenH - DCTopNavH);
        
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"MG_Empty_dizhi"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = PFR13Font;
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"您还没有收货地址" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2 , 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}


- (NSMutableArray<DCAdressItem *> *)adItem
{
    if (!_adItem) {
        _adItem = [NSMutableArray array];
    }
    return _adItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];

    [self setUpAccNote];
}

- (void)setUpAccNote
{
    WEAKSELF
    [[NSNotificationCenter defaultCenter] addObserverForName:@"UpDateUI" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.adItem = [[DCAdressDateBase sharedDataBase] getAllAdressItem]; //本地数据库
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - initialize
- (void)setUpBase
{
    self.title = @"收货地址";
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.bgTipButton];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.tableFooterView = [UIView new];
    self.adItem = [[DCAdressDateBase sharedDataBase] getAllAdressItem]; //本地数据库
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"nav_btn_tianjia"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"nav_btn_tianjia"] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(addButtonBarItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, backButton];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.bgTipButton.hidden = (_adItem.count > 0) ? YES : NO;
    return self.adItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    DCUserAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:DCUserAdressCellID forIndexPath:indexPath];
    cell.adItem = _adItem[indexPath.row];
    
    cell.deleteClickBlock = ^{  //删除地址
        
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakSelf.view makeToast:@"删除成功" duration:0.5 position:CSToastPositionCenter];
            [[DCAdressDateBase sharedDataBase] deleteAdress:weakSelf.adItem[indexPath.row]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //处理数据
                [weakSelf.adItem removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
            });
        });
        
    };
    cell.editClickBlock = ^{ //编辑地址
    
        DCNewAdressViewController *dcNewVc = [DCNewAdressViewController new];
        dcNewVc.adressItem = weakSelf.adItem[indexPath.row];
        dcNewVc.saveType = DCSaveAdressChangeType;
        [weakSelf.navigationController pushViewController:dcNewVc animated:YES];
        
    };
    
    cell.selectBtnClickBlock = ^(BOOL isSelected) { //默认选择点击
        
        NSInteger index = indexPath.row;
        for (NSInteger i = 0; i < weakSelf.adItem.count; i++) {
            DCAdressItem *adressItem = weakSelf.adItem[i];
            adressItem.isDefault = (i == index && isSelected) ? @"2" : @"1";
            [[DCAdressDateBase sharedDataBase]updateAdress:adressItem];
        }
        
        weakSelf.adItem = [[DCAdressDateBase sharedDataBase] getAllAdressItem];
        [weakSelf.tableView reloadData];
    };
    
    return cell;
}


#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _adItem[indexPath.row].cellHeight;
}

#pragma mark - 添加地址点击
- (void)addButtonBarItemClick
{
    DCNewAdressViewController *dcNewVc = [DCNewAdressViewController new];
    dcNewVc.saveType = DCSaveAdressNewType;
    [self.navigationController pushViewController:dcNewVc animated:YES];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
