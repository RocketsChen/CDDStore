//
//  DCBeautyShopRecommendCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBeautyShopRecommendCell.h"

#import "DCStoresRecommendCell.h"

#import "DCPageControl.h"

@interface DCBeautyShopRecommendCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/* 顶部标题View */
@property (weak, nonatomic) IBOutlet UIView *topTitleView;
/* 底部上架View */
@property (weak, nonatomic) IBOutlet UIView *bottomPutawayView;
/* 页面 */
@property (strong , nonatomic)DCPageControl *pageControl;

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;


@end

static NSString *const DCStoresRecommendCellID = @"DCStoresRecommendCell";

@implementation DCBeautyShopRecommendCell

#pragma mark - LoadLazy
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        dcFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        dcFlowLayout.minimumLineSpacing = dcFlowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DCStoresRecommendCell class]) bundle:nil] forCellWithReuseIdentifier:DCStoresRecommendCellID];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self seUpPageControl];
    
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}


#pragma mark - 设置分页点
- (void)seUpPageControl
{
    self.pageControl = [[DCPageControl alloc]initWithFrame:CGRectZero];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.numberOfPages = 4;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    [self addSubview:self.pageControl];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_topTitleView.mas_bottom)setOffset:DCMargin];
        [make.left.mas_equalTo(self)setOffset:5];
        [make.right.mas_equalTo(self)setOffset:-5];
        [make.bottom.mas_equalTo(_bottomPutawayView.mas_top)setOffset:-DCMargin];
    }];
    
    _pageControl.frame = CGRectMake(self.dc_width * 0.5 - 40, self.bottomPutawayView.dc_y - DCMargin, 80, DCMargin);//指定位置
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _beaShopItem.count;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DCStoresRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCStoresRecommendCellID forIndexPath:indexPath];
    cell.shopItem = _beaShopItem[indexPath.row];
    
    return cell;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
}


#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第%zd个推荐的商品",indexPath.row);
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_collectionView.dc_width / 3, _collectionView.dc_height);
}

@end
