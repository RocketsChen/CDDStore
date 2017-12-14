//
//  DCBeautyHotTopicCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBeautyHotTopicCell.h"

#import "DCBeautyHotItem.h"

#import "DCGroupImageCell.h"

@interface DCBeautyHotTopicCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *hotTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *watchNumLabel;
/* 图片模型 */
@property (strong , nonatomic)NSMutableArray *picArray;

@end

static NSString *const DCGroupImageCellID = @"DCGroupImageCell";

@implementation DCBeautyHotTopicCell

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

- (NSMutableArray *)picArray
{
    if (!_picArray) {
        _picArray = [NSMutableArray array];
    }
    return _picArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_subTitleLabel.mas_bottom)setOffset:DCMargin];
        [make.left.mas_equalTo(self)setOffset:5];
        [make.right.mas_equalTo(self)setOffset:-5];
        [make.bottom.mas_equalTo(_watchNumLabel.mas_top)setOffset:-DCMargin];
    }];
}

- (void)setHotItem:(DCBeautyHotItem *)hotItem
{
    _hotItem = hotItem;
    self.hotTitleLabel.text = hotItem.beautyTitle;
    self.subTitleLabel.text = hotItem.secondTitle;
    [self.watchNumLabel setTitle:[NSString stringWithFormat:@"%@ 万",hotItem.watchNum] forState:0];
    
    _picArray = [NSMutableArray arrayWithArray:hotItem.groupImage];
}



#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _picArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCGroupImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGroupImageCellID forIndexPath:indexPath];
    NSString *groupIamgeUrl = _picArray[indexPath.row];
    cell.groupImageUrl = groupIamgeUrl;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_collectionView.dc_height, _collectionView.dc_height);
}


@end
