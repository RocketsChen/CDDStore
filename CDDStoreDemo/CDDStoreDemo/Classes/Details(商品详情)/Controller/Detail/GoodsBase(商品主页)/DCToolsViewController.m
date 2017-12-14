//
//  DCToolsViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/7/11.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCToolsViewController.h"

// Controllers

// Models

// Views

// Vendors

// Categories
#import "UIViewController+XWTransition.h"
// Others

@interface DCToolsViewController ()



@end

@implementation DCToolsViewController

#pragma mark - LazyLoad


#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUpShareAlterView];
    
    [self setUpTopView];
}

- (void)setUpTopView
{
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setImage:[UIImage imageNamed:@"ptgd_icon_shuaxin"] forState:0];

    [self.view addSubview:refreshButton];
    [refreshButton addTarget:self action:@selector(refreshButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(ScreenH - 120);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    NSArray *images = @[@"ptgd_icon_home",@"ptgd_icon_fenlei",@"ptgd_icon_xiaoxi",@"ptgd_icon_share"];
    CGFloat buttonW = ScreenW / 4;
    CGFloat buttonH = 40;
    CGFloat buttonY = ScreenH - 60;
    for (NSInteger i = 0; i < images.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:images[i]] forState:0];
        [self.view addSubview:button];
        button.tag = i;
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button addTarget:self action:@selector(toolsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)toolsButtonClick:(UIButton *)button
{
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:SHAREALTERVIEW object:nil];
    });
}
- (void)refreshButtonClick
{
    [self cancelButtonClick];
}

#pragma mark - 弹出弹框
- (void)setUpShareAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    WEAKSELF
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } edgeSpacing:0];
}

#pragma mark - 取消点击
- (void)cancelButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
