//
//  DCBaseViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCBaseViewController.h"

#import "DCBaseItem.h"
#import "DCBaseServiceCell.h"

#import "DCConsts.h"
#import "UIView+DCExtension.h"
#import "UIViewController+XWTransition.h"

#import <Masonry.h>
#import <MJExtension.h>

@interface DCBaseViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSArray<DCBaseItem *> *baseItem;

@end

static NSString *const DCBaseServiceCellID = @"DCBaseServiceCell";
@implementation DCBaseViewController

#pragma mark - 懒加载
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
    
    [self setUpBaseAlterView];
    
    [self setUpTab];
    
    [self setUpHeadView];
    
    [self setUpFooterView];
    
    [self loadBaseData];
    
}


#pragma mark - 加载基础等信息
- (void)loadBaseData{
    
    NSArray *baseItem = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"StoreBase.plist" ofType:nil]];
    _baseItem = [DCBaseItem mj_objectArrayWithKeyValuesArray:baseItem];
    
    [self.tableView reloadData];
}


#pragma mark - 头部视图
- (void)setUpHeadView
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.dc_size = CGSizeMake(ScreenW, 50);
    titleLabel.text = @"基础服务";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = titleLabel;
}

#pragma mark - 尾部视图
- (void)setUpFooterView
{
    UIView *footerView = [[UIView alloc] init];
    footerView.dc_size = CGSizeMake(ScreenW, 110);
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.backgroundColor = [UIColor redColor];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(selfViewBack) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:sureButton];
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(footerView);
        make.left.mas_equalTo(footerView);
        make.bottom.mas_equalTo(footerView);
        make.height.mas_equalTo(@(50));
    }];
    
    self.tableView.tableFooterView = footerView;
}

- (void)setUpTab
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.scrollEnabled = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCBaseServiceCell class]) bundle:nil] forCellReuseIdentifier:DCBaseServiceCellID];
}

#pragma mark - 弹出弹框
- (void)setUpBaseAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    __weak typeof(self)weakSelf = self;
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf selfViewBack];
    } edgeSpacing:0];
}

#pragma mark - 退出当前View
- (void)selfViewBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCBaseServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:DCBaseServiceCellID forIndexPath:indexPath];
    
    cell.baseItem = _baseItem[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 65;
    }else
    {
        return 80;
    }
}


@end
