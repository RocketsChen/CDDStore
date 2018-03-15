//
//  DCLoginViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/28.
//Copyright © 2017年 STO. All rights reserved.
//

#import "DCLoginViewController.h"

// Controllers
#import "DCNavigationController.h"
#import "DCTabBarController.h"
#import "DCRegisteredViewController.h"
// Models

// Views
#import "DCAccountPsdView.h" //账号密码登录
#import "DCVerificationView.h" //验证码登录
// Vendors

// Categories

// Others

@interface DCLoginViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *middleLoginView;

/* 上一次选中的按钮 */
@property (strong , nonatomic)UIButton *selectBtn;
/* indicatorView */
@property (strong , nonatomic)UIView *indicatorView;
/* titleView */
@property (strong , nonatomic)UIView *titleView;
/* contentView */
@property (strong , nonatomic)UIScrollView *contentView;

/* 验证码 */
@property (strong , nonatomic)DCVerificationView *verificationView;
/* 账号密码登录 */
@property (strong , nonatomic)DCAccountPsdView *accountPsdView;
@end

@implementation DCLoginViewController

#pragma mark - LazyLoad
- (UIScrollView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.bounces = NO;
        _contentView.delegate = self;
    }
    return _contentView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sertUpBase];
    
    [self setUpTiTleView];
    
    [self setUpContentView];
}

#pragma mark - base
- (void)sertUpBase {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    
}

#pragma mark - 标题登录
- (void)setUpTiTleView
{
    _titleView = [UIView new];
    _titleView.frame = CGRectMake(0, 0, ScreenW, 35);
    [_middleLoginView addSubview:_titleView];
    
    NSArray *titleArray = @[@"账号密码登录",@"短信验证登录"];
    CGFloat buttonW = (_titleView.dc_width - 30) / 2;
    CGFloat buttonH = _titleView.dc_height - 3;
    CGFloat buttonX = 15;
    CGFloat buttonY = 0;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        
        UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = PFR16Font;
        button.tag = i;
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.frame = CGRectMake((i * buttonW) + buttonX, buttonY, buttonW, buttonH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:button];
    }
    
    UIButton *firstButton = _titleView.subviews[0];
    [self buttonClick:firstButton];
    
    _indicatorView = [UIView new];
    _indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    
    
    [firstButton.titleLabel sizeToFit];
    
    _indicatorView.dc_height = 2;
    _indicatorView.dc_width = firstButton.titleLabel.dc_width;
    _indicatorView.dc_centerX = firstButton.dc_centerX;
    _indicatorView.dc_y = _titleView.dc_bottom - _indicatorView.dc_height;
    [_titleView addSubview:_indicatorView];
    
    self.contentView.contentSize = CGSizeMake(ScreenW * titleArray.count, 0);
}


#pragma mark - 按钮点击
- (void)buttonClick:(UIButton *)button
{
    button.selected = !button.selected;
    [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _selectBtn = button;
    
    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.dc_width = button.titleLabel.dc_width;
        weakSelf.indicatorView.dc_centerX = button.dc_centerX;
    }];
    
    CGPoint offset = _contentView.contentOffset;
    offset.x = _contentView.dc_width * button.tag;
    [_contentView setContentOffset:offset animated:YES];
}

#pragma mark - 内容
- (void)setUpContentView
{
    
    self.contentView.backgroundColor = [UIColor orangeColor];
    self.contentView.frame = CGRectMake(0, _titleView.dc_bottom + DCMargin, ScreenW, _middleLoginView.dc_height - _titleView.dc_bottom - DCMargin);
    [self.middleLoginView addSubview:_contentView];
    
    _verificationView = [DCVerificationView dc_viewFromXib];
    [_contentView addSubview:_verificationView];
    _accountPsdView = [DCAccountPsdView dc_viewFromXib];
    [_contentView addSubview:_accountPsdView];

    _verificationView.frame = CGRectMake(ScreenW, 0, ScreenW, _middleLoginView.dc_height - _titleView.dc_height);
    _accountPsdView.frame = CGRectMake(0, 0, ScreenW, _middleLoginView.dc_height - _titleView.dc_height);
}

#pragma mark - 注册
- (IBAction)registAccount {
    
    DCRegisteredViewController *dcRegistVc = [DCRegisteredViewController new];
    [self.navigationController pushViewController:dcRegistVc animated:YES];
}

#pragma mark - 退出当前界面
- (IBAction)dismissViewController {
    
    
    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.dc_width;
    UIButton *button = _titleView.subviews[index];
    
    [self buttonClick:button];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end

