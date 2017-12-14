//
//  DCCenterServiceCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/13.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCenterServiceCell.h"

// Controllers

// Models

// Views
#import "DCGoodsGridCell.h"
// Vendors

// Categories

// Others

@interface DCCenterServiceCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *topTitleView;

/* collectioView */
@property (strong , nonatomic)UICollectionView *collectionView;

@end

static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";

@implementation DCCenterServiceCell

#pragma mark - LoadLazy
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        dcFlowLayout.minimumLineSpacing = dcFlowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[DCGoodsGridCell class] forCellWithReuseIdentifier:DCGoodsGridCellID];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}


#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
        make.top.mas_equalTo(_topTitleView.mas_bottom);
    }];
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _serviceItemArray.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsGridCellID forIndexPath:indexPath];
    
    cell.gridItem = _serviceItemArray[indexPath.row];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW / 4, 85);
}


@end
