//
//  DCComImagesView.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/23.
//Copyright © 2018年 RocketsChen. All rights reserved.
//
#define MiddleImageH  (CGRectGetWidth([UIScreen mainScreen].bounds) - 40)/5
#define MiddleImageW  MiddleImageH

#import "DCComImagesView.h"

// Controllers
#import "DCComPicViewController.h"
// Models
#import "DCCommentsItem.h"
// Views
#import "DCItemImageCell.h"
// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCComImagesView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *itemImages;

@end

static NSString *const DCItemImageCellID = @"DCItemImageCell";

@implementation DCComImagesView

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        dcFlowLayout.minimumLineSpacing = 5;
        dcFlowLayout.minimumInteritemSpacing = 0;
        
        dcFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [self addSubview:_collectionView];
        
        //注册
        [_collectionView registerClass:[DCItemImageCell class] forCellWithReuseIdentifier:DCItemImageCellID];
    }
    return _collectionView;
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}


#pragma mark - UI
- (void)setUpUI
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    WEAKSELF
    [[NSNotificationCenter defaultCenter] addObserverForName:@"UpDataImageView" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf.collectionView reloadData];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _picUrlArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCItemImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCItemImageCellID forIndexPath:indexPath];
    
    
    [cell.itemImageView sd_setImageWithURL:[NSURL URLWithString:_picUrlArray[indexPath.row]]placeholderImage:[UIImage imageNamed:@"default_50"]];
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(MiddleImageW, MiddleImageH);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    DCComPicViewController *dcComVc = [DCComPicViewController new];
    [dcComVc setUpComPicAttribute:^(NSArray *__autoreleasing *imageArray, NSString *__autoreleasing *comComtent, NSString *__autoreleasing *comSpecifications, NSInteger *selectCount) {
        
        *imageArray = weakSelf.picUrlArray;
        *comComtent = weakSelf.comContent;
        *comSpecifications = weakSelf.comSpecifications;
        
        *selectCount = indexPath.row;
    }];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:dcComVc animated:YES completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setter Getter Methods

@end
