//
//  DCDetailPartCommentCell.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCDetailPartCommentCell.h"

// Controllers

// Models

// Views
#import "DCCommentHeaderCell.h"
#import "DCCommentFooterCell.h"
#import "DCCommentContentCell.h"
// Vendors

// Categories

// Others

@interface DCDetailPartCommentCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

@end

static NSString *const DCCommentHeaderCellID = @"DCCommentHeaderCell";
static NSString *const DCCommentFooterCellID = @"DCCommentFooterCell";
static NSString *const DCCommentContentCellID = @"DCCommentContentCell";

@implementation DCDetailPartCommentCell

#pragma mark - LoadLazy
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        //注册
        [_collectionView registerClass:[DCCommentHeaderCell class] forCellWithReuseIdentifier:DCCommentHeaderCellID];
        [_collectionView registerClass:[DCCommentFooterCell class] forCellWithReuseIdentifier:DCCommentFooterCellID];
        [_collectionView registerClass:[DCCommentContentCell class] forCellWithReuseIdentifier:DCCommentContentCellID];
        
        [self addSubview:_collectionView];
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
    self.collectionView.backgroundColor = self.backgroundColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (section == 0 || section == 1) ? 1 : 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//头部
        DCCommentHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCCommentHeaderCellID forIndexPath:indexPath];
        cell.comNum = @"668";
        cell.wellPer = @"100%";
        gridcell = cell;
    }else if (indexPath.section == 1){//中间
        DCCommentContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCCommentContentCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor orangeColor];
        gridcell = cell;
    }else if (indexPath.section == 2){ //底部
        DCCommentFooterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCCommentFooterCellID forIndexPath:indexPath];
        NSArray *images = @[@"JX_pinglun1_liebiao",@"ptgd_icon_zixun"];
        NSArray *titles = @[@"全部评论（188）",@"购买咨询（22）"];
        [cell.commentFootButton setImage:[UIImage imageNamed:images[indexPath.row]] forState:UIControlStateNormal];
        [cell.commentFootButton setTitle:titles[indexPath.row] forState:UIControlStateNormal];
        
        cell.isShowLine = (indexPath.row == 0)  ? YES:NO; //分割线
        
        gridcell = cell;
    }
    return gridcell;
}


#pragma mark - <UICollectionViewDelegate>
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 0) ? CGSizeMake(ScreenW, 30)  : (indexPath.section == 2) ? CGSizeMake(ScreenW / 2, 40)  : CGSizeMake(ScreenW, 200);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:SCROLLTOCOMMENTSPAGE object:nil];
    });
}

#pragma mark - Setter Getter Methods


@end
