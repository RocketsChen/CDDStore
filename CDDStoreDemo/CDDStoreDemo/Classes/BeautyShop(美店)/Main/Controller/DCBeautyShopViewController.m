//
//  DCBeautyShopViewController.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/12/1.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBeautyShopViewController.h"

// Controllers
#import "DCLoginViewController.h"
// Models
#import "DCBeautyHotItem.h"
#import "DCBeautyShopItem.h"
// Views

#import "DCSlideshowHeadView.h"

#import "DCBeautyTopToolView.h"
#import "DCBeautyShopRecommendCell.h"//第一组Cell
#import "DCBestBeautyShopCell.h" //第二组Cell
#import "DCBeautyHotTopicCell.h" //第三组Cell

#import "DCStoresRecommendHeaderView.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface DCBeautyShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* 顶部按钮 */
@property (nonatomic, strong) DCBeautyTopToolView *topToolView;
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 热贴 */
@property (strong , nonatomic)NSMutableArray<DCBeautyHotItem *> *hotItem;
/* 推荐商品 */
@property (strong , nonatomic)NSMutableArray<DCBeautyShopItem *> *beaShopItem;
@end

/* head */
static NSString *const DCStoresRecommendHeaderViewID = @"DCStoresRecommendHeaderView";
static NSString *const DCSlideshowHeadViewID = @"DCSlideshowHeadView";
/* cell */
static NSString *const DCBeautyShopRecommendCellID = @"DCBeautyShopRecommendCell";
static NSString *const DCBestBeautyShopCellID = @"DCBestBeautyShopCell";
static NSString *const DCBeautyHotTopicCellID = @"DCBeautyHotTopicCell";


@implementation DCBeautyShopViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - DCBottomTabH);
        _collectionView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_collectionView];
        
        //header
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DCStoresRecommendHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCStoresRecommendHeaderViewID];
        
        //footer
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"beatyFooterView"];
        
        //cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DCBeautyShopRecommendCell class]) bundle:nil] forCellWithReuseIdentifier:DCBeautyShopRecommendCellID];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DCBestBeautyShopCell class]) bundle:nil] forCellWithReuseIdentifier:DCBestBeautyShopCellID];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DCBeautyHotTopicCell class]) bundle:nil] forCellWithReuseIdentifier:DCBeautyHotTopicCellID];
        
    }
    return _collectionView;
}

- (NSMutableArray<DCBeautyHotItem *> *)hotItem
{
    if (!_hotItem) {
        _hotItem = [NSMutableArray array];
    }
    return _hotItem;
}

- (NSMutableArray<DCBeautyShopItem *> *)beaShopItem
{
    if (!_beaShopItem) {
        _beaShopItem = [NSMutableArray array];
    }
    return _beaShopItem;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpNavTopView];
    
    [self setUpBeautyData];
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = self.view.backgroundColor;
}

#pragma mark - 获取数据
- (void)setUpBeautyData
{
    _hotItem = [DCBeautyHotItem mj_objectArrayWithFilename:@"BeautyShop.plist"];
    _beaShopItem = [DCBeautyShopItem mj_objectArrayWithFilename:@"BeautyRecommendShop.plist"];
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[DCBeautyTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    _topToolView.leftItemClickBlock = ^{
        NSLog(@"点击了我要开店");
    };
    _topToolView.rightItemClickBlock = ^{
        NSLog(@"点击了消息");
    };

    [self.view addSubview:_topToolView];
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (section == 2) ? _hotItem.count : 1 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *beautyCell = nil;
    if (indexPath.section == 0) {
        DCBeautyShopRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCBeautyShopRecommendCellID forIndexPath:indexPath];
        cell.beaShopItem = _beaShopItem;
        beautyCell = cell;
        
    }else if (indexPath.section == 1){
        DCBestBeautyShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCBestBeautyShopCellID forIndexPath:indexPath];
        beautyCell = cell;
        
    }else if (indexPath.section == 2){
        DCBeautyHotTopicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCBeautyHotTopicCellID forIndexPath:indexPath];
        cell.hotItem = _hotItem[indexPath.row];
        beautyCell = cell;
    }
    return beautyCell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *beautyReusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) { //轮播图
            DCSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID forIndexPath:indexPath];
            headerView.imageGroupArray = GoodsBeautySilderImagesArray;
            beautyReusableView = headerView;
        }
        if (indexPath.section == 2) { //头部
            DCStoresRecommendHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCStoresRecommendHeaderViewID forIndexPath:indexPath];
            beautyReusableView =  headerView;
        }
        
    }else if (kind == UICollectionElementKindSectionFooter){ //尾部
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"beatyFooterView" forIndexPath:indexPath];
        beautyReusableView = footerView;
    }
    
    return beautyReusableView;
    
}

#pragma mark - Cell Header Footer 高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(ScreenW, 380);
    }else if (indexPath.section == 1){
        return CGSizeMake(ScreenW, 180);
    }else if (indexPath.section == 2){
        return CGSizeMake(ScreenW, 250);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(ScreenW, 230);
    }else if (section == 2){
        return CGSizeMake(ScreenW, 35);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(ScreenW, DCMargin);
}


#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;
    
    if (scrollView.contentOffset.y > DCNaviH) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
    }
    
}

@end
