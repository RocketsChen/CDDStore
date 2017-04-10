//
//  DCUserPayViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/4/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCUserPayViewController.h"

#import "DCConsts.h"
#import "DCPayWayCell.h"

#import "UIView+DCExtension.h"

#import <Masonry.h>

@interface DCUserPayViewController ()<UITableViewDelegate,UITableViewDataSource>

/* 支付方式数组 */
@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic , strong) UITableView *tableView;

@end


static NSString *DCPayWayCellID = @"DCPayWayCell";

@implementation DCUserPayViewController

#pragma mark - 懒加载
- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr=@[@{@"icon":@"zfb_",@"name":@"支付宝支付",@"des":@"推荐有支付宝帐号的用户使用"},@{@"icon":@"wx_",@"name":@"微信支付",@"des":@"推荐安装微信的用户使用"},@{@"icon":@"yl_",@"name":@"银联支付",@"des":@"银联支付快捷又安全"}];
    }
    return _dataArr;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.contentInset = UIEdgeInsetsMake(124, 0, 0, 0);
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
    
    [self setUpTopView];
    
    [self setUpTabHead];
    
}


- (void)setUpTab
{
    self.title = @"支付订单";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = DCRGBColor(242, 242, 242);
    self.view.backgroundColor = DCRGBColor(242, 242, 242);
}

#pragma mark - 顶部视图
- (void)setUpTopView
{
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UILabel *orderMoneyLabel = [[UILabel alloc] init];
    orderMoneyLabel.text = @"订单金额";
    orderMoneyLabel.font = [UIFont systemFontOfSize:16];
    orderMoneyLabel.frame = CGRectMake(10, 0, 200, 50);
    [topView addSubview:orderMoneyLabel];
    UILabel *shopsMoneyLabel = [[UILabel alloc] init];
    NSString *lastPayMoney = [NSString stringWithFormat:@"%.2f",_lastPayMoney];
    shopsMoneyLabel.text = [NSString stringWithFormat:@"¥ %0.2f",[lastPayMoney floatValue]];
    shopsMoneyLabel.font = [UIFont systemFontOfSize:18];
    shopsMoneyLabel.textAlignment = NSTextAlignmentRight;
    shopsMoneyLabel.textColor = [UIColor orangeColor];
    shopsMoneyLabel.frame = CGRectMake(ScreenW - 130, 0, 120, 50);
    [topView addSubview:shopsMoneyLabel];
    
    topView.frame = CGRectMake(0, 74, ScreenW, 50);
}

#pragma mark - tableView头部视图
- (void)setUpTabHead
{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *chosePayLabel = [[UILabel alloc] init];
    chosePayLabel.text = @"选择支付方式";
    chosePayLabel.font = [UIFont systemFontOfSize:16];
    [headView addSubview:chosePayLabel];
    headView.dc_height = 50;
    headView.dc_width = ScreenW;
    chosePayLabel.frame = CGRectMake(DCMargin, 0, 100, 50);
    self.tableView.tableHeaderView = headView;
    self.tableView.tableHeaderView.dc_height = 50;
    
    
    [self setUpCellAcrossPartingLineWith:headView WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3] WithHight:1];
}


#pragma mark - 下划线
-(void)setUpCellAcrossPartingLineWith:(UIView *)view WithColor:(UIColor*)color WithHight:(CGFloat)height
{
    UIView *cellAcrossPartingLine = [[UIView alloc] init];
    cellAcrossPartingLine.backgroundColor = color;
    [view addSubview:cellAcrossPartingLine];
    
    [cellAcrossPartingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left);
        make.right.mas_equalTo(view.mas_right);
        make.bottom.mas_equalTo(view.mas_bottom);
        make.height.mas_equalTo(@(height));
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArr count];;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self setUpBottomViewWith:[self.dataArr[indexPath.row] valueForKey:@"name"]];
}

#pragma mark - 底部
- (void)setUpBottomViewWith:(NSString *)str
{
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.backgroundColor = [UIColor redColor];
    [payButton setTitle:str forState:UIControlStateNormal];
    payButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [payButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
    
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(self.view.mas_width);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(@(55));
    }];
    
}

#pragma mark - 去支付
- (void)payButtonClick:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:[self.dataArr[0] valueForKey:@"name"]]) {
        NSLog(@"跳转到支付宝支付界面");
        
    }else if ([button.titleLabel.text isEqualToString:[self.dataArr[1] valueForKey:@"name"]])
    {
        NSLog(@"跳转到微信支付界面");
        
    }else{
        NSLog(@"跳转到银联支付界面");
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DCPayWayCell *cell=[tableView dequeueReusableCellWithIdentifier:DCPayWayCellID];
    if (!cell) {
        cell=[[DCPayWayCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DCPayWayCellID];
    }
    [cell.imageView setImage:[UIImage imageNamed:[self.dataArr[indexPath.row] valueForKey:@"icon"]]];
    [cell.textLabel setText:[self.dataArr[indexPath.row] valueForKey:@"name"]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    [cell.detailTextLabel setText:[self.dataArr[indexPath.row] valueForKey:@"des"]];
    [cell.detailTextLabel setTextColor:[UIColor lightGrayColor]];
    
    return cell;
}

@end
