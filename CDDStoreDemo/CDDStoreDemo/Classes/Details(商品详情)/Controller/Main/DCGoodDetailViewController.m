//
//  DCGoodDetailViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodDetailViewController.h"

// Controllers
#import "DCGoodBaseViewController.h"
#import "DCGoodParticularsViewController.h"
#import "DCGoodCommentViewController.h"
#import "DCMyTrolleyViewController.h"
#import "DCToolsViewController.h"
// Models

// Views

// Vendors

#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others

@interface DCGoodDetailViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UIView *bgView;
/** 记录上一次选中的Button */
@property (nonatomic , weak) UIButton *selectBtn;
/* 标题按钮地下的指示器 */
@property (weak ,nonatomic) UIView *indicatorView;
/* 通知 */
@property (weak ,nonatomic) id dcObserve;

@end

@implementation DCGoodDetailViewController

#pragma mark - LazyLoad
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.bounces = NO;
        _scrollerView.delegate = self;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}

#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpChildViewControllers];
    
    [self setUpInit];
    
    [self setUpNav];
    
    [self setUpTopButtonView];
    
    [self addChildViewController];
    
    [self setUpBottomButton];
    
    [self acceptanceNote];
}

#pragma mark - initialize
- (void)setUpInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.contentSize = CGSizeMake(self.view.dc_width * self.childViewControllers.count, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 接受通知
- (void)acceptanceNote
{
    //滚动到详情
    __weak typeof(self)weakSlef = self;
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:SCROLLTODETAILSPAGE object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSlef topBottonClick:weakSlef.bgView.subviews[1]]; //跳转详情
    }];
    
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:SCROLLTOCOMMENTSPAGE object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSlef topBottonClick:weakSlef.bgView.subviews[2]]; //跳转到评论界面
    }];
}

#pragma mark - 头部View
- (void)setUpTopButtonView
{
    NSArray *titles = @[@"商品",@"详情",@"评价"];
    CGFloat margin = 5;
    _bgView = [[UIView alloc] init];
    _bgView.dc_centerX = ScreenW * 0.5;
    _bgView.dc_height = 44;
    _bgView.dc_width = (_bgView.dc_height + margin) * titles.count;
    _bgView.dc_y = 0;
    self.navigationItem.titleView = _bgView;
    
    CGFloat buttonW = _bgView.dc_height;
    CGFloat buttonH = _bgView.dc_height;
    CGFloat buttonY = _bgView.dc_y;
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.font = PFR16Font;
        [button addTarget:self action:@selector(topBottonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = i * (buttonW + margin);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [_bgView addSubview:button];
        
    }
    
    UIButton *firstButton = _bgView.subviews[0];
    [self topBottonClick:firstButton]; //默认选择第一个
    
    UIView *indicatorView = [[UIView alloc]init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    
    indicatorView.dc_height = 2;
    indicatorView.dc_y = _bgView.dc_height - indicatorView.dc_height;
    
    [firstButton.titleLabel sizeToFit];
    indicatorView.dc_width = firstButton.titleLabel.dc_width;
    indicatorView.dc_centerX = firstButton.dc_centerX;
    
    [_bgView addSubview:indicatorView];

}

#pragma mark - 添加子控制器View
-(void)addChildViewController
{
    NSInteger index = _scrollerView.contentOffset.x / _scrollerView.dc_width;
    UIViewController *childVc = self.childViewControllers[index];
    
    if (childVc.view.superview) return; //判断添加就不用再添加了
    childVc.view.frame = CGRectMake(index * _scrollerView.dc_width, 0, _scrollerView.dc_width, _scrollerView.dc_height);
    [_scrollerView addSubview:childVc.view];
    
}

#pragma mark - 添加子控制器
-(void)setUpChildViewControllers
{
    WEAKSELF
    DCGoodBaseViewController *goodBaseVc = [[DCGoodBaseViewController alloc] init];
    goodBaseVc.goodTitle = _goodTitle;
    goodBaseVc.goodPrice = _goodPrice;
    goodBaseVc.goodSubtitle = _goodSubtitle;
    goodBaseVc.shufflingArray = _shufflingArray;
    goodBaseVc.goodImageView = _goodImageView;
    goodBaseVc.changeTitleBlock = ^(BOOL isChange) {
        if (isChange) {
            weakSelf.title = @"图文详情";
            weakSelf.navigationItem.titleView = nil;
            weakSelf.scrollerView.contentSize = CGSizeMake(weakSelf.view.dc_width, 0);
        }else{
            weakSelf.title = nil;
            [weakSelf.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            weakSelf.navigationItem.titleView = weakSelf.bgView;
            weakSelf.scrollerView.contentSize = CGSizeMake(weakSelf.view.dc_width * weakSelf.childViewControllers.count, 0);
        }
    };
    [self addChildViewController:goodBaseVc];
    
    DCGoodParticularsViewController *goodParticularsVc = [[DCGoodParticularsViewController alloc] init];
    [self addChildViewController:goodParticularsVc];
    
    DCGoodCommentViewController *goodCommentVc = [[DCGoodCommentViewController alloc] init];
    [self addChildViewController:goodCommentVc];
}

#pragma mark - 底部按钮(收藏 购物车 加入购物车 立即购买)
- (void)setUpBottomButton
{
    [self setUpLeftTwoButton];//收藏 购物车
    
    [self setUpRightTwoButton];//加入购物车 立即购买
}
#pragma mark - 收藏 购物车
- (void)setUpLeftTwoButton
{
    NSArray *imagesNor = @[@"tabr_07shoucang_up",@"tabr_08gouwuche"];
    NSArray *imagesSel = @[@"tabr_07shoucang_down",@"tabr_08gouwuche"];
    CGFloat buttonW = ScreenW * 0.2;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    
    for (NSInteger i = 0; i < imagesNor.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonW = ScreenW * 0.6 * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = PFR16Font;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 2;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? [UIColor redColor] : RGB(249, 125, 10);
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = ScreenW * 0.4 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildViewController];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.dc_width;
    UIButton *button = _bgView.subviews[index];
    
    [self topBottonClick:button];
    
    [self addChildViewController];
}

#pragma mark - 导航栏设置
- (void)setUpNav
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"Details_Btn_More_normal"] WithHighlighted:[UIImage imageNamed:@"Details_Btn_More_normal"] Target:self action:@selector(toolItemClick)];
}


#pragma mark - 点击事件
#pragma mark - 头部按钮点击
- (void)topBottonClick:(UIButton *)button
{
    button.selected = !button.selected;
    [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _selectBtn = button;
    
    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.dc_width = button.titleLabel.dc_width;
        weakSelf.indicatorView.dc_centerX = button.dc_centerX;
    }];
    
    CGPoint offset = _scrollerView.contentOffset;
    offset.x = _scrollerView.dc_width * button.tag;
    [_scrollerView setContentOffset:offset animated:YES];
}

#pragma mark - 点击工具条
- (void)toolItemClick
{
    [self setUpAlterViewControllerWith:[DCToolsViewController new] WithDistance:150 WithDirection:XWDrawerAnimatorDirectionTop WithParallaxEnable:NO WithFlipEnable:NO];
}

- (void)bottomButtonClick:(UIButton *)button
{
    if (button.tag == 0) {
        NSLog(@"收藏");
        button.selected = !button.selected;
    }else if(button.tag == 1){
        NSLog(@"购物车");
        DCMyTrolleyViewController *shopCarVc = [[DCMyTrolleyViewController alloc] init];
        shopCarVc.isTabBar = YES;
        shopCarVc.title = @"购物车";
        [self.navigationController pushViewController:shopCarVc animated:YES];
    }else  if (button.tag == 2 || button.tag == 3) { //父控制器的加入购物车和立即购买
        //异步发通知
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%zd",button.tag],@"buttonTag", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:SELECTCARTORBUY object:nil userInfo:dict];
        });
    }
}



#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable
{
    
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    WEAKSELF
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
    
    
}

#pragma 退出界面
- (void)selfAlterViewback{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 消失
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObserve];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}


@end
