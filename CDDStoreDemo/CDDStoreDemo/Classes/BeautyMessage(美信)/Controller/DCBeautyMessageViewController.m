//
//  DCBeautyMessageViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/21.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBeautyMessageViewController.h"

// Controllers
#import "DCLoginViewController.h"
// Models

// Views
#import "YBPopupMenu.h"
#import "DCBeautyMsgCell.h"
// Vendors
#import "UIBarButtonItem+DCBarButtonItem.h"
// Categories

// Others

@interface DCBeautyMessageViewController ()<UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;

/* 弹框 */
@property (nonatomic, strong) YBPopupMenu *popupMenu;

@end

static NSString *const DCBeautyMsgCellID = @"DCBeautyMsgCell";

@implementation DCBeautyMessageViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - DCBottomTabH);
    
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCBeautyMsgCell class]) bundle:nil] forCellReuseIdentifier:DCBeautyMsgCellID];
    }
    
    return _tableView;
}

#pragma mark - LifeCyle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"美信(未连接)";
    self.tableView.backgroundColor = DCBGColor;
    self.tableView.tableFooterView = [UIView new];
    
    [self setUpNav];
}


#pragma mark - 设置导航栏
- (void)setUpNav
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"emoticon_group_add"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"emoticon_group_add"] forState:UIControlStateSelected];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(addItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, backButton];
}




#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCBeautyMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:DCBeautyMsgCellID forIndexPath:indexPath];
    
    NSArray *contentArray = @[@[@"message_logo",@"message_logo"],@[@"朋友圈",@"消息中心"]];
    
    cell.msgImageView.image = [UIImage imageNamed:contentArray[0][indexPath.row]];
    cell.msgLabel.text = contentArray[1][indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
        
        DCLoginViewController *dcLoginVc = [DCLoginViewController new];
        [self presentViewController:dcLoginVc animated:YES completion:nil];
        
    }else{
        [DCSpeedy dc_SetUpAlterWithView:self Message:@"小圆点需要为您改变为一个随机数么" Sure:^{
            
             NSInteger value = arc4random() % 100;
            [DCObjManager dc_saveUserData:[NSString stringWithFormat:@"%zd",value] forKey:@"isLogin"]; //暂时以登录记录字段相关联，后续会新建字段
            [[NSNotificationCenter defaultCenter]postNotificationName:DCMESSAGECOUNTCHANGE object:nil];
            
        } Cancel:nil];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    NSLog(@"点击了%@",ybPopupMenu.titles[index]);
}


#pragma mark - 加好点击
- (void)addItemClick:(UIButton *)sender
{
    [YBPopupMenu showRelyOnView:sender titles:TITLES icons:ICONS menuWidth:180 delegate:self];
    
}



@end
