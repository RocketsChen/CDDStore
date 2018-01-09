

//
//  DCNewFeatureViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/20.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCNewFeatureViewController.h"

// Controllers
#import "DCTabBarController.h"
// Models

// Views
#import "DCNewFeatureCell.h"
// Vendors

// Categories

// Others

@interface DCNewFeatureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionview */
@property (strong , nonatomic)UICollectionView *collectionView;

/* 图片数组 */
@property (nonatomic, copy) NSArray *imageArray;

/** 是否显示跳过按钮, 默认不显示 */
@property (nonatomic, assign) BOOL showSkip;
/** 是否显示page小圆点, 默认不显示 */
@property (nonatomic, assign) BOOL showPageCount;

/* 小圆点选中颜色 */
@property (nonatomic, strong) UIColor *selColor;
/* 跳过按钮 */
@property (nonatomic, strong) UIButton *skipButton;

/* page */
@property (strong , nonatomic)UIPageControl *pageControl;

@end

static NSString *const DCNewFeatureCellID = @"DCNewFeatureCell";

@implementation DCNewFeatureViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        dcFlowLayout.minimumLineSpacing = dcFlowLayout.minimumInteritemSpacing = 0;
        dcFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = [UIScreen mainScreen].bounds;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [self.view insertSubview:_collectionView atIndex:0];
        
        [_collectionView registerClass:[DCNewFeatureCell class] forCellWithReuseIdentifier:DCNewFeatureCellID];
    }
    return _collectionView;
}

- (UIButton *)skipButton
{
    if (!_skipButton) {
        
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.frame = CGRectMake(ScreenW - 85, 30, 65, 30);
        [_skipButton addTarget:self action:@selector(skipButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _skipButton.hidden = YES;
        _skipButton.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.8];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _skipButton.layer.cornerRadius = 15;
        _skipButton.layer.masksToBounds = YES;
        
        [self.view addSubview:_skipButton];
    }
    return _skipButton;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl && _imageArray.count != 0) {
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = _imageArray.count;
        _pageControl.userInteractionEnabled = false;
        [_pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        UIColor *currColor = (_selColor == nil) ? [UIColor darkGrayColor] : _selColor;
        [self.pageControl setCurrentPageIndicatorTintColor:currColor];
        _pageControl.frame = CGRectMake(0, ScreenH * 0.95, ScreenW, 35);
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}

#pragma mark - 基础设置
- (void)setUpFeatureAttribute:(void(^)(NSArray **imageArray,UIColor **selColor,BOOL *showSkip,BOOL *showPageCount))BaseSettingBlock{
    
    NSArray *imageArray;
    UIColor *selColor;
    
    BOOL showSkip;
    BOOL showPageCount;
    
    if (BaseSettingBlock) {
        BaseSettingBlock(&imageArray,&selColor,&showSkip,&showPageCount);
        
        self.imageArray = imageArray;
        self.selColor = selColor;
        self.showSkip = showSkip;
        self.showPageCount = showPageCount;
    }
    
}

#pragma mark - 是否展示跳过按钮
- (void)setShowSkip:(BOOL)showSkip
{
    _showSkip = showSkip;
    self.skipButton.hidden = !self.showSkip;
}

#pragma mark - 是否展示page小圆点
- (void)setShowPageCount:(BOOL)showPageCount
{
    _showPageCount = showPageCount;
    self.pageControl.hidden = !self.showPageCount;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DCBGColor;
    
    [self.skipButton setTitle:@"跳过" forState:0];
    self.collectionView.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = false;

}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCNewFeatureCellID forIndexPath:indexPath];
    
    cell.nfImageView.image = (DCIsiPhoneX) ? [UIImage imageNamed:[NSString stringWithFormat:@"%@_x",_imageArray[indexPath.row]]]  : [UIImage imageNamed:_imageArray[indexPath.row]];
    
    cell.hideBtnImg = @"hidden";
    [cell dc_GetCurrentPageIndex:indexPath.row lastPageIndex:_imageArray.count - 1];
    
    WEAKSELF
    cell.hideButtonClickBlock = ^{
        
        [weakSelf restoreRootViewController:[[DCTabBarController alloc] init]];
    };
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW, ScreenH);
}

#pragma mark - 通过代理来让她滑到最后一页再左滑动就切换控制器
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (_imageArray.count < 2) return; //一张图或者没有直接返回
    _collectionView.bounces = (scrollView.contentOffset.x > (_imageArray.count - 2) * ScreenW) ? YES : NO;
    if (scrollView.contentOffset.x >  (_imageArray.count - 1) * ScreenW) {
        [self restoreRootViewController:[[DCTabBarController alloc] init]];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (!_showPageCount) return;
    CGPoint currentPoint = scrollView.contentOffset;
    NSInteger page = currentPoint.x / scrollView.dc_width;
    _pageControl.currentPage = page;
}

- (void)restoreRootViewController:(UIViewController *)rootViewController {
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.7f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
        
    } completion:nil];
}


#pragma mark - 跳过点击
- (void)skipButtonClick
{
    [self restoreRootViewController:[[DCTabBarController alloc] init]];
}

@end

