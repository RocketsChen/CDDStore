
//
//  DCCenterItemCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/12.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCenterItemCell.h"

// Controllers

// Models
#import "DCStateItem.h"
// Views
#import "DCStateItemCell.h"
#import "DCStateItemFooterView.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface DCCenterItemCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 数据 */
@property (strong , nonatomic)NSMutableArray<DCStateItem *> *stateItem;
@end

static NSString *const DCStateItemCellID = @"DCStateItemCell";

static NSString *const DCStateItemFooterViewID = @"DCStateItemFooterView";

@implementation DCCenterItemCell

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        dcFlowLayout.minimumLineSpacing = dcFlowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;

        //注册Cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DCStateItemCell class]) bundle:nil] forCellWithReuseIdentifier:DCStateItemCellID];
        //注册footerView
        [_collectionView registerClass:[DCStateItemFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCStateItemFooterViewID];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray<DCStateItem *> *)stateItem
{
    if (!_stateItem) {
        _stateItem = [NSMutableArray array];
    }
    return _stateItem;
}

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = DCBGColor;
    _stateItem = [DCStateItem mj_objectArrayWithFilename:@"MyCenterFlow.plist"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _stateItem.count;
}


#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCStateItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCStateItemCellID forIndexPath:indexPath];
    cell.stateItem = _stateItem[indexPath.row];//赋值
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionFooter) {
        DCStateItemFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCStateItemFooterViewID forIndexPath:indexPath];
        reusableView = footer;
    }
    return reusableView;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW / 5, 90);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(ScreenW, 0);
}

@end
