//
//  DCFootprintGoodsViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/15.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define FootprintScreenW ScreenW * 0.4

#import "DCFootprintGoodsViewController.h"

// Controllers

// Models
#import "DCRecommendItem.h"
// Views
#import "DCFootprintCell.h"
// Vendors
#import <MJExtension.h>
#import "UIViewController+XWTransition.h"
// Categories

// Others

@interface DCFootprintGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>

/* 整个足迹浏览View */
@property (strong , nonatomic)UIView *footprintView;

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 足迹数据 */
@property (strong , nonatomic)NSMutableArray<DCRecommendItem *> *footprintItem;

@end

static NSString *DCFootprintCellID = @"DCFootprintCell";

@implementation DCFootprintGoodsViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
    
        [_tableView registerClass:[DCFootprintCell class] forCellReuseIdentifier:DCFootprintCellID];
    }
    return _tableView;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpFootprintAlterView];
    
    [self setUpInit];

    [self setUpHeadTitle];
    
    [self setUpData];
}

#pragma mark - initialize
- (void)setUpInit
{
    self.view.backgroundColor = DCBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _footprintView = [[UIView alloc] init];
    _footprintView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_footprintView];
    [_footprintView addSubview:_tableView];

    _footprintView.frame = CGRectMake(0, 0, FootprintScreenW, ScreenH);
}

#pragma mark - 足迹数据
- (void)setUpData
{
    _footprintItem = [DCRecommendItem mj_objectArrayWithFilename:@"FootprintGoods.plist"];
}

#pragma mark - 我的足迹
- (void)setUpHeadTitle
{
    UILabel *myFootLabel = [[UILabel alloc] init];
    myFootLabel.text = @"我的足迹";
    myFootLabel.textAlignment = NSTextAlignmentCenter;
    myFootLabel.font = PFR15Font;
    
    [_footprintView addSubview:myFootLabel];
    myFootLabel.frame  = CGRectMake(0, 20, FootprintScreenW, 44);
    
    _tableView.frame = CGRectMake(0, myFootLabel.dc_bottom, FootprintScreenW, ScreenH - myFootLabel.dc_bottom);
}

#pragma mark - 弹出弹框
- (void)setUpFootprintAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionLeft;
    WEAKSELF
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf selfViewBack];
    } edgeSpacing:80];
}

#pragma mark - 退出当前View
- (void)selfViewBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _footprintItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCFootprintCell *cell = [tableView dequeueReusableCellWithIdentifier:DCFootprintCellID forIndexPath:indexPath];
    cell.footprintItem = _footprintItem[indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return FootprintScreenW + 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了足迹的第%zd条数据",indexPath.row);
}



@end
