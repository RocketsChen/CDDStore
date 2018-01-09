//
//  DCNewAdressViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/19.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCNewAdressViewController.h"

// Controllers

// Models

// Views
#import "DCNewAdressView.h"
// Vendors

// Categories

// Others

@interface DCNewAdressViewController ()<UITableViewDelegate,UITableViewDataSource>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;

/* headView */
@property (strong , nonatomic)DCNewAdressView *adressHeadView;

@end

@implementation DCNewAdressViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.frame = CGRectMake(0, DCTopNavH + 20, ScreenW, ScreenH - (DCTopNavH + 20 + 45));
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
    }
    return _tableView;
}


#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpHeadView];
}

- (void)setUpBase
{
    self.title = @"新增收货人地址";
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"保存" forState:0];
    button.frame = CGRectMake(0, 0, 44, 44);
    button.titleLabel.font = PFR16Font;
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:self action:@selector(saveButtonBarItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, backButton];
}


#pragma mark - 头部View
- (void)setUpHeadView
{
    _adressHeadView = [DCNewAdressView dc_viewFromXib];
    _adressHeadView.frame = CGRectMake(0, 0, ScreenW, 210);
    
    self.tableView.tableHeaderView = _adressHeadView;
    self.tableView.tableFooterView = [UIView new];
    
    _adressHeadView.selectAdBlock = ^{
        NSLog(@"选择地址");
    };
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - 保存新地址
- (IBAction)saveNewAdressClick {
    
}

#pragma mark - 点击保存
- (void)saveButtonBarItemClick
{
    
}

@end
