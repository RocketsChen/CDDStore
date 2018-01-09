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
// Views
#import "DCUserAdressCell.h"
#import "DCUpDownButton.h"
// Vendors

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

}

#pragma mark - initialize
- (void)setUpBase
{
    self.title = @"收货地址";
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.bgTipButton];
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCUserAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:DCUserAdressCellID forIndexPath:indexPath];
    cell.deleteClickBlock = ^{
        
    };
    cell.deleteClickBlock = ^{
    
    };
    
    cell.selectBtnClickBlock = ^(BOOL isSelected) {
        
    };
    
    return cell;
}


#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

#pragma mark - 添加地址点击
- (void)addButtonBarItemClick
{
    DCNewAdressViewController *dcNewVc = [DCNewAdressViewController new];
    [self.navigationController pushViewController:dcNewVc animated:YES];
}

@end
