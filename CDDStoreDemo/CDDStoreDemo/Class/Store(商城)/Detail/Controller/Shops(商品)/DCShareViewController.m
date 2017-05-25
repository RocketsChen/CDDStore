//
//  DCShareViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCShareViewController.h"

#import "DCConsts.h"
#import "DCStoreButton.h"
#import "UIViewController+XWTransition.h"

#import <Masonry.h>

@interface DCShareViewController ()

@end

@implementation DCShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpShareView];
    
    [self setUpShareAlterView];
}

#pragma mark - 创建分享View
- (void)setUpShareView
{
    self.view.backgroundColor = DCRGBColor(239, 239, 239);
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor = [UIColor redColor];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(selfViewBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    
    NSArray *titles = @[@"微信朋友圈",@"微信好友",@"手机QQ"];
    NSArray *imgs = @[@"wechat friend",@"wechat",@"tencent"];
    
    CGFloat buttonW = ScreenW / titles.count;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        DCStoreButton *button = [DCStoreButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        button.frame = CGRectMake(buttonW * i, 0, buttonW, 145);
        [button addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.height.mas_equalTo(@(50));
        make.top.mas_equalTo(self.view).offset(150);
        make.width.mas_equalTo(self.view);
    }];
    
}

#pragma mark - 分享点击
- (void)shareButtonClick:(UIButton *)button
{
    if (button.tag == 0) {
        NSLog(@"点击了微信朋友圈");
        
    }else if (button.tag == 1){
        NSLog(@"微信好友");
    }else{
        NSLog(@"手机QQ");
    }
    [self selfViewBack];
}

#pragma mark - 弹出弹框
- (void)setUpShareAlterView
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

@end
