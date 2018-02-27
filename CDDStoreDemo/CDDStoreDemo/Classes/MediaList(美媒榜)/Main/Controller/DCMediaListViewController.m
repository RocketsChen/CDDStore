//
//  DCMediaListViewController.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/12/1.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCMediaListViewController.h"

// Controllers
#import "DCMRViewController.h" //推荐
#import "DCMQViewController.h" //圈子
#import "DCMVViewController.h" //视频
// Models

// Views
#import "YBPopupMenu.h"
#import "DCMediaTopToolView.h"
// Vendors

// Categories

// Others

@interface DCMediaListViewController ()<YBPopupMenuDelegate>

/* 顶部按钮 */
@property (nonatomic, strong) DCMediaTopToolView *topToolView;

@end

@implementation DCMediaListViewController

#pragma mark - LazyLoad


#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpNavTopView];
    
    [self setUpDisplayStyle:^(UIColor *__autoreleasing *titleScrollViewBgColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIColor *__autoreleasing *proColor, UIFont *__autoreleasing *titleFont, CGFloat *titleButtonWidth, BOOL *isShowPregressView, BOOL *isOpenStretch, BOOL *isOpenShade) {
        *norColor = [UIColor darkGrayColor];
        *selColor = [UIColor redColor];
        *proColor = [UIColor redColor];
        *titleFont = PFR16Font
        
        *titleButtonWidth = 65;
        
        *isShowPregressView = YES;
        *isOpenStretch = YES;
        *isOpenShade = YES;
    }];
    
    
    [self setUpProgressAttribute:^(CGFloat *progressLength, CGFloat *progressHeight) {
        *progressHeight = 3;
    }];
    
    [self setUpTopTitleViewAttribute:^(CGFloat *topDistance, CGFloat *titleViewHeight) {
        *topDistance = 64;
    }];
    
    
    [self setUpAllChildViewController];
}


#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    WEAKSELF
    _topToolView = [[DCMediaTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    _topToolView.leftItemClickBlock = ^{
    };
    _topToolView.rightItemClickBlock = ^(UIButton *sender) {
        [YBPopupMenu showRelyOnView:sender titles:TITLES icons:ICONS menuWidth:180 delegate:weakSelf];
    };
    _topToolView.searchButtonClickBlock = ^{
        NSLog(@"点击了美媒榜搜索");
    };
    [self.view addSubview:_topToolView];
}


#pragma mark - 添加所有子控制器
- (void)setUpAllChildViewController
{

    DCMRViewController *vc01 = [DCMRViewController new];
    vc01.title = @"推荐";
    vc01.url = @"https://www.jianshu.com/p/8bcdde249137";
    [self addChildViewController:vc01];
    
    DCMQViewController *vc02 = [DCMQViewController new];
    vc02.title = @"圈子";
    vc02.url = @"https://www.jianshu.com/p/1b19028dc975";
    [self addChildViewController:vc02];
    
    DCMVViewController *vc03 = [DCMVViewController new];
    vc03.title = @"视频";
    vc03.url = @"http://www.jianshu.com/p/3f248b614bdc";
    [self addChildViewController:vc03];
}



#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    NSLog(@"点击了%@",ybPopupMenu.titles[index]);
}


@end
