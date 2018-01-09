//
//  DCGMScanViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/1/9.
//Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "DCGMScanViewController.h"

// Controllers

// Models

// Views
#import "DCCameraTopView.h"
// Vendors

// Categories

// Others

@interface DCGMScanViewController ()<DCScanBackDelegate>

/* 顶部工具View */
@property (nonatomic, strong) DCCameraTopView *cameraTopView;

@end

@implementation DCGMScanViewController

#pragma mark - LazyLoad


#pragma mark - LifeCyle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpTopView];
    
    [self setUpBottomView];
}

#pragma mark - initialize
- (void)setUpBase
{
    self.scanDelegate = self;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark - 导航栏处理
- (void)setUpTopView
{
    _cameraTopView = [[DCCameraTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    WEAKSELF
    _cameraTopView.leftItemClickBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    _cameraTopView.rightItemClickBlock = ^{
        [weakSelf flashButtonClick:weakSelf.flashButton];
    };
    
    _cameraTopView.rightRItemClickBlock = ^{
        [weakSelf jumpPhotoAlbum];
    };
    
    [self.view addSubview:_cameraTopView];
}
- (void)setUpBottomView
{
    UIView *bottomView = [UIView new];
    bottomView.frame = CGRectMake(0, ScreenH - 65, ScreenW, 50);
    UILabel *supLabel = [UILabel new];
    
    supLabel.text = @"支持扫描";
    supLabel.font = self.tipLabel.font;
    supLabel.textAlignment = NSTextAlignmentCenter;
    supLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
    supLabel.frame = CGRectMake(0, 0, ScreenW, 20);
    [bottomView addSubview:supLabel];
    
    NSArray *titles = @[@"快递单",@"物价码",@"二维码"];
    NSArray *images = @[@"",@"",@""];
    CGFloat btnW = (ScreenW - 80) / titles.count;
    CGFloat btnH = bottomView.dc_height - supLabel.dc_bottom - 5;
    CGFloat btnX;
    CGFloat btnY = supLabel.frame.size.height + supLabel.frame.origin.y + 5;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitleColor:RGBA(245, 245, 245, 1) forState:UIControlStateNormal];
        
        btnX = 40 + (i * btnW);
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [bottomView addSubview:button];
    }
    
    [self.view addSubview:bottomView];
}

#pragma mark - <DCScanBackDelegate>
- (void)DCScanningSucessBackWithInfor:(NSString *)message
{
    NSLog(@"代理回调扫描识别结果%@",message);
}

@end
