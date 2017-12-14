
//
//  DCBestBeautyShopCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBestBeautyShopCell.h"

#import "DCGroupImageCell.h"

@interface DCBestBeautyShopCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *topTitleView;

@end

static NSString *const DCGroupImageCellID = @"DCGroupImageCell";

@implementation DCBestBeautyShopCell


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        dcFlowLayout.minimumLineSpacing = dcFlowLayout.minimumInteritemSpacing = 0;
        dcFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[DCGroupImageCell class] forCellWithReuseIdentifier:DCGroupImageCellID];
        
    }
    return _collectionView;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_topTitleView.mas_bottom)setOffset:DCMargin];
        [make.left.mas_equalTo(self)setOffset:5];
        [make.right.mas_equalTo(self)setOffset:-5];
        [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
    }];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return BeastBeautyShopArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCGroupImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGroupImageCellID forIndexPath:indexPath];
    NSString *groupIamgeUrl = BeastBeautyShopArray[indexPath.row];
    cell.groupImageUrl = groupIamgeUrl;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_collectionView.dc_height * 1.3, _collectionView.dc_height);
}


@end
