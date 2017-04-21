//
//  DCStoreGridFlowLayout.m
//  CDDStoreDemo
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreGridFlowLayout.h"

//每行显示两个
static NSUInteger const DCCount = 2;

@interface DCStoreGridFlowLayout()

@property (nonatomic, strong) NSMutableDictionary *attributes;
@property (nonatomic, strong) NSMutableArray *colArr;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout> delegate;

@end

@implementation DCStoreGridFlowLayout

#pragma mark 准备布局
- (void)prepareLayout {
    [super prepareLayout];
    // 获取总的个数
    NSUInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    if (!itemCount) {
        return;
    }
    
    // 初始化
    self.attributes = [[NSMutableDictionary alloc] init];
    self.colArr = [NSMutableArray arrayWithCapacity:DCCount];
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    
    //_colArr 用来存放相邻的两个高度
    CGFloat top = .0f;
    for (NSUInteger idx = 0; idx < DCCount; idx ++) {
        [_colArr addObject:[NSNumber numberWithFloat:top]];
    }
    
    // 遍历所有的item，重新布局
    for (NSUInteger idx = 0; idx < itemCount; idx ++) {
        [self layoutItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]];
    }
}


- (void)layoutItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获取collectionView的edgeInsets
    UIEdgeInsets edgeInsets = self.sectionInset;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.row];
    }
    self.edgeInsets = edgeInsets;
    
    // 获取collectionView的itemSize
    CGSize itemSize = self.itemSize;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    
    // 遍历相邻两个高度获取最小高度
    NSUInteger col = 0;
    CGFloat shortHeight = [[_colArr firstObject] floatValue];
    for (NSUInteger idx = 0; idx < _colArr.count; idx ++) {
        CGFloat height = [_colArr[idx] floatValue];
        if (height < shortHeight) {
            shortHeight = height;
            col = idx;
        }
    }
    // 得到最小高度的当前Y坐标起始高度
    float top = [[_colArr objectAtIndex:col] floatValue];
    // 设置当前cell的frame
    CGRect frame = CGRectMake(edgeInsets.left + col * (edgeInsets.left + itemSize.width), top + edgeInsets.top, itemSize.width, itemSize.height);
    // 把对应的indexPath存放到字典中保存
    [_attributes setObject:indexPath forKey:NSStringFromCGRect(frame)];
    
    // 跟新colArr数组中的高度
    [_colArr replaceObjectAtIndex:col withObject:[NSNumber numberWithFloat:top + edgeInsets.top + itemSize.height]];
}

// 系统方法，获取当前可视界面显示的UICollectionViewLayoutAttributes数组
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 把能显示在当前可视界面的所有对象加入在indexPaths 中
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSString *rectStr in _attributes) {
        CGRect cellRect = CGRectFromString(rectStr);
        if (CGRectIntersectsRect(cellRect, rect)) {
            NSIndexPath *indexPath = _attributes[rectStr];
            [indexPaths addObject:indexPath];
        }
    }
    
    // 返回更新对应的UICollectionViewLayoutAttributes数组
    NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath *indexPath in indexPaths) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes addObject:attribute];
    }
    return attributes;
}

// 更新对应UICollectionViewLayoutAttributes的frame
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    for (NSString *frame in _attributes) {
        if (_attributes[frame] == indexPath) {
            attributes.frame = CGRectFromString(frame);
        }
    }
    
    return attributes;
}

- (CGSize)collectionViewContentSize {
    CGSize size = self.collectionView.frame.size;
    CGFloat maxHeight = [[_colArr firstObject] floatValue];
    
    //查找最高的列的高度
    for (NSUInteger idx = 0; idx < _colArr.count; idx++) {
        CGFloat colHeight = [_colArr[idx] floatValue];
        if (colHeight > maxHeight) {
            maxHeight = colHeight;
        }
    }
    
    size.height = maxHeight + self.edgeInsets.bottom;
    return size;
}


@end

