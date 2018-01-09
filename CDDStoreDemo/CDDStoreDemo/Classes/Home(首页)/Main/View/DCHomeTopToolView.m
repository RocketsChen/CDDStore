//
//  DCHomeTopToolView.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/11/28.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCHomeTopToolView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCHomeTopToolView ()

/* 左边Item */
@property (strong , nonatomic)UIButton *leftItemButton;
/* 右边Item */
@property (strong , nonatomic)UIButton *rightItemButton;
/* 右边第二个Item */
@property (strong , nonatomic)UIButton *rightRItemButton;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;
/* 语音按钮 */
@property (strong , nonatomic)UIButton *voiceButton;
/* 通知 */
@property (weak ,nonatomic) id dcObserve;
@end

@implementation DCHomeTopToolView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
        [self acceptanceNote];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    
    _leftItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"shouye_icon_scan_white"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _rightItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"shouye_icon_sort_white"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _rightRItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"icon_gouwuche_title_white"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightRButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:_rightItemButton];
    [self addSubview:_rightRItemButton];
    [self addSubview:_leftItemButton];
    
    CAGradientLayer * layer = [[CAGradientLayer alloc] init];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.2].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.15].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.05].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.03].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.01].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
    [self.layer addSublayer:layer];
    
    _topSearchView = [[UIView alloc] init];
    _topSearchView.backgroundColor = [UIColor whiteColor];
    _topSearchView.layer.cornerRadius = 16;
    [_topSearchView.layer masksToBounds];
    [self addSubview:_topSearchView];
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"彩电年终内购会" forState:0];
    [_searchButton setTitleColor:[UIColor lightGrayColor] forState:0];
    _searchButton.titleLabel.font = PFR13Font;
    [_searchButton setImage:[UIImage imageNamed:@"group_home_search_gray"] forState:0];
    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * DCMargin, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, DCMargin, 0, 0);
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_topSearchView addSubview:_searchButton];
    
    _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _voiceButton.adjustsImageWhenHighlighted = NO;
    [_voiceButton addTarget:self action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_voiceButton setImage:[UIImage imageNamed:@"icon_voice_search"] forState:0];
    [_topSearchView addSubview:_voiceButton];
    
}

#pragma mark - 接受通知
- (void)acceptanceNote
{
    //滚动到详情
    WEAKSELF
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:SHOWTOPTOOLVIEW object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.backgroundColor = [UIColor whiteColor];
        _topSearchView.backgroundColor = RGB(240, 240, 240);
        [weakSelf.leftItemButton setImage:[UIImage imageNamed:@"shouye_icon_scan_gray"] forState:0];
        [weakSelf.rightItemButton setImage:[UIImage imageNamed:@"shouye_icon_sort_gray"] forState:0];
        [weakSelf.rightRItemButton setImage:[UIImage imageNamed:@"icon_gouwuche_title_gray"] forState:0];
    }];
    
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:HIDETOPTOOLVIEW object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.backgroundColor = [UIColor clearColor];
        _topSearchView.backgroundColor = [UIColor whiteColor];
        [weakSelf.leftItemButton setImage:[UIImage imageNamed:@"shouye_icon_scan_white"] forState:0];
        [weakSelf.rightItemButton setImage:[UIImage imageNamed:@"shouye_icon_sort_white"] forState:0];
        [weakSelf.rightRItemButton setImage:[UIImage imageNamed:@"icon_gouwuche_title_white"] forState:0];
    }];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftItemButton.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    [_rightRItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftItemButton.mas_centerY);
        make.right.equalTo(_rightItemButton.mas_left).offset(5);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    [_topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_leftItemButton.mas_right)setOffset:5];
        [make.right.mas_equalTo(_rightRItemButton.mas_left)setOffset:5];
        make.height.mas_equalTo(@(32));
        make.centerY.mas_equalTo(_rightRItemButton);
        
    }];
    
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_topSearchView);
        make.top.mas_equalTo(_topSearchView);
        make.height.mas_equalTo(_topSearchView);
        [make.right.mas_equalTo(_topSearchView)setOffset:-2*DCMargin];
    }];
    
    [_voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_topSearchView);
        make.centerY.mas_equalTo(_topSearchView);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
}

#pragma mark - 消失
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObserve];
}
#pragma 自定义右边导航Item点击
- (void)rightButtonItemClick {
    !_rightItemClickBlock ? : _rightItemClickBlock();
}

#pragma 自定义左边导航Item点击
- (void)leftButtonItemClick {
    
    !_leftItemClickBlock ? : _leftItemClickBlock();
}

#pragma mark - 自定义右边第二个导航Item点击
- (void)rightRButtonItemClick
{
    !_rightRItemClickBlock ? : _rightRItemClickBlock();
}

#pragma mark - 搜索按钮点击
- (void)searchButtonClick
{
    !_searchButtonClickBlock ? : _searchButtonClickBlock();
}


#pragma mark - 语音按钮点击
- (void)voiceButtonClick
{
    !_voiceButtonClickBlock ? : _voiceButtonClickBlock();
}

@end
