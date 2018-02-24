//
//  DCComHeadView.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/23.
//Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "DCComHeadView.h"

// Controllers

// Models

// Views
#import "DCCometItemCell.h"
#import "DCCollectionHeaderLayout.h"
// Vendors

// Categories

// Others

@interface DCComHeadView ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,HorizontalCollectionLayoutDelegate>

/* 提示label */
@property (strong , nonatomic)UILabel *tipLabel;

/* 百分比label */
@property (strong , nonatomic)UILabel *percentageLabel;

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

@end

static NSString *const DCCometItemCellID = @"DCCometItemCell";

@implementation DCComHeadView

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        DCCollectionHeaderLayout *layout = [DCCollectionHeaderLayout new];
        layout.delegate = self;
        layout.lineSpacing = DCMargin;
        layout.interitemSpacing = DCMargin;
        layout.labelFont = PFR14Font;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        
        [_collectionView registerClass:[DCCometItemCell class] forCellWithReuseIdentifier:DCCometItemCellID];
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


- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView selectItemAtIndexPath:index animated:YES scrollPosition:UICollectionViewScrollPositionNone]; //默认选择
    
    _tipLabel = [UILabel new];
    [self addSubview:_tipLabel];
    _tipLabel.text = @"好评度";
    _tipLabel.textColor = [UIColor darkGrayColor];
    _tipLabel.font = PFR13Font;
    
    
    _percentageLabel = [UILabel new];
    _percentageLabel.font = PFR18Font;
    _percentageLabel.textColor = RGB(235, 0, 72);
    [self addSubview:_percentageLabel];
    _percentageLabel.text = @"99%";
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.width.mas_equalTo(@50);
        [make.right.mas_equalTo(self)setOffset:- 2 * DCMargin];
        
    }];
    
    [_percentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tipLabel.mas_bottom);
        make.width.mas_equalTo(@50);
        make.right.mas_equalTo(_tipLabel);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        [make.right.mas_equalTo(_tipLabel.mas_left)setOffset:-5];
    }];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCCometItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCCometItemCellID forIndexPath:indexPath];
    cell.itemLabel.text = @[@"全部",@"好评(23)",@"中评(1)",@"差评(1)",@"不看默认评价"][indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    !_comTypeBlock ? : _comTypeBlock(indexPath.row);
}
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    return @[@"全部",@"好评(23)",@"中评(1)",@"差评(1)",@"不看默认评价"][indexPath.row];
}



#pragma mark - Setter Getter Methods

@end
