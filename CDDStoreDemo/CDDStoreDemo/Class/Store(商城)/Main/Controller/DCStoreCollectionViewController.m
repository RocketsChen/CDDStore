//
//  DCStoreCollectionViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreCollectionViewController.h"
#import "DCCustomViewController.h"
#import "DCStoreDetailViewController.h"

#import "DCStoreItem.h"
#import "DCStoreGridFlowLayout.h"
#import "DCStoreCollectionViewCell.h"
#import "DCStoreGridCollectionCell.h"

#import "DCConsts.h"
#import "DCSpeedy.h"
#import "DCCustomButton.h"
#import "DCStoreCoverLabel.h"
#import "UIView+DCExtension.h"
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

#import <Masonry.h>
#import <MJExtension.h>

@interface DCStoreCollectionViewController()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
/* 数据 */
@property (strong , nonatomic)NSMutableArray<DCStoreItem *> *storeItem;

/* 视图状态 */
@property (nonatomic, assign) BOOL isGrid;

@property (nonatomic, strong) DCStoreGridFlowLayout *layout;

@property (nonatomic, strong) DCStoreCollectionViewCell *collectionCell;
@property (nonatomic, strong) DCStoreGridCollectionCell *gridCell;
@end
static UIView *coverView ;
static NSString *DCStoreCollectionViewCellID = @"DCStoreCollectionViewCell";
static NSString *DCStoreGridCollectionCellID = @"DCStoreGridCollectionCell";

@implementation DCStoreCollectionViewController
{
    UIButton *diffButton;
    UIButton *sameButton;
    DCStoreCoverLabel *nameLabel;
    DCStoreCoverLabel *desLabel;
    DCStoreCoverLabel *serLabel;
    DCStoreCoverLabel *exLabel;
    
}

#pragma mark - 懒加载

- (NSMutableArray<DCStoreItem *> *)storeItem
{
    if (!_storeItem) {
        _storeItem = [NSMutableArray array];
    }
    return _storeItem;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        if (_isGrid) {//视图布局
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, ScreenH - 50) collectionViewLayout:self.layout];
        }else{//列表布局
            UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, ScreenH - 50) collectionViewLayout:flowlayout];
            [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
            flowlayout = [[DCStoreGridFlowLayout alloc] init];
            flowlayout.minimumInteritemSpacing = DCMargin;
            flowlayout.minimumLineSpacing = DCMargin;
            flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        }
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        //注册cell
        [_collectionView registerClass:[DCStoreCollectionViewCell class] forCellWithReuseIdentifier:DCStoreCollectionViewCellID];
        [_collectionView registerClass:[DCStoreGridCollectionCell class] forCellWithReuseIdentifier:DCStoreGridCollectionCellID];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.collectionView];
    }
    return _collectionView;
}

- (DCStoreGridFlowLayout *)layout {
    if (!_layout) {
        _layout = [[DCStoreGridFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = DCMargin;
        _layout.minimumLineSpacing = DCMargin;
        _layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return _layout;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTab];
    
    [self loadStoreDatas];
    
    [self setUpSeachPhoneView:self.view];
}

#pragma mark - 搜索
- (void)setUpSeachPhoneView:(UIView *)view
{
    UIView *seachPhoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 50)];
    seachPhoneView.backgroundColor = [UIColor whiteColor];
    
    UILabel *showNum_Label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenW * 0.4, 50)];
    [seachPhoneView addSubview:showNum_Label];
    NSString *shopCount = [NSString stringWithFormat:@"%zd",_storeItem.count];
    showNum_Label.text = [NSString stringWithFormat:@"共筛选出 %@ 件商品",shopCount];
    showNum_Label.font = [UIFont systemFontOfSize:12];
    
    [DCSpeedy setSomeOneChangeColor:showNum_Label SetSelectArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"] SetChangeColor:[UIColor orangeColor]];
    
    DCCustomButton *customButton = [DCCustomButton buttonWithType:UIButtonTypeCustom];
    customButton.frame = CGRectMake(ScreenW - 70, 0 , 60 , 50);
    [customButton setTitle:@"筛选" forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:@"custom"] forState:UIControlStateNormal];
    customButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [customButton addTarget:self action:@selector(customButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [seachPhoneView addSubview:customButton];
    
    UIButton *swithBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [swithBtn addTarget:self action:@selector(garidButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [swithBtn setImage:[UIImage imageNamed:@"product_list_list_btn"] forState:UIControlStateNormal];
    
    swithBtn.frame = CGRectMake(ScreenW - 120, 0, 50, 50);
    
    [seachPhoneView addSubview:swithBtn];
    
    [view addSubview:seachPhoneView];
}

#pragma mark - 筛选点击
- (void)customButtonClick
{
    XWDrawerAnimatorDirection direction = XWDrawerAnimatorDirectionRight;
    CGFloat distance = ScreenW * 0.8; //分享窗口宽度
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.toDuration = 0.5;
    animator.backDuration = 0.5;
    animator.parallaxEnable = YES;
    //点击当前界面返回
    DCCustomViewController *shopsCustomVc = [[DCCustomViewController alloc] init];
    shopsCustomVc.sureButtonClickBlock = ^(NSString *attributeViewBrandString,NSString * attributeViewSortString){
        
        NSLog(@"刷选回调 选择的品牌：%@   展示方式：%@",attributeViewBrandString,attributeViewSortString);
    };
    
    [self xw_presentViewController:shopsCustomVc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
    
}

#pragma 退出界面
- (void)selfAlterViewback{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)garidButtonClick:(UIButton *)btn
{
    _isGrid = !_isGrid;
    [self.collectionView reloadData];
    
    if (_isGrid) {
        [btn setImage:[UIImage imageNamed:@"product_list_grid_btn"] forState:0];
    } else {
        [btn setImage:[UIImage imageNamed:@"product_list_list_btn"] forState:0];
    }
}


- (void)loadStoreDatas
{
    NSArray *storeArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"MallShops.plist" ofType:nil]];
    _storeItem = [DCStoreItem mj_objectArrayWithKeyValuesArray:storeArray];
    
    [self.collectionView reloadData];
}

- (void)setUpTab
{
    self.title = @"商城";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isGrid = NO;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _storeItem.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isGrid) {
        DCStoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCStoreCollectionViewCellID forIndexPath:indexPath];
        _collectionCell = cell;
        cell.storeItem = self.storeItem[indexPath.row];
        __weak typeof(cell)weakCell = cell;
        cell.choseMoreBlock = ^(UIImageView *image) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                coverView = [UIButton buttonWithType:UIButtonTypeCustom];
            });
            
            coverView.dc_width = weakCell.contentView.dc_width;
            coverView.dc_height = 0;
            coverView.dc_x = weakCell.contentView.dc_x;
            [UIView animateWithDuration:0.5 animations:^{
                coverView.dc_height = weakCell.contentView.dc_height;
            }];
            
            coverView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
            
            diffButton = [[UIButton alloc] init];
            [diffButton setTitle:@"无相同" forState:UIControlStateNormal];
            diffButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [diffButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [diffButton setBackgroundColor:[UIColor redColor]];
            [diffButton addTarget:self action:@selector(CollnoDiff) forControlEvents:UIControlEventTouchUpInside];
            
            sameButton = [[UIButton alloc] init];
            [sameButton setTitle:@"找相似" forState:UIControlStateNormal];
            sameButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [sameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [sameButton setBackgroundColor:[UIColor orangeColor]];
            [sameButton addTarget:self action:@selector(ColllookSame) forControlEvents:UIControlEventTouchUpInside];
            
            [DCSpeedy chageControlCircularWith:diffButton AndSetCornerRadius:coverView.dc_width * 0.2 SetBorderWidth:0 SetBorderColor:0 canMasksToBounds:YES];
            [DCSpeedy chageControlCircularWith:sameButton AndSetCornerRadius:coverView.dc_width * 0.2 SetBorderWidth:0 SetBorderColor:0 canMasksToBounds:YES];
            
            [weakCell.contentView addSubview:coverView];
            [coverView addSubview:diffButton];
            [coverView addSubview:sameButton];
            
            [diffButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(coverView.mas_width).multipliedBy(0.4);
                [make.bottom.mas_equalTo(coverView.mas_centerY)setOffset:5];
                make.centerX.mas_equalTo(coverView.mas_centerX);
                make.width.mas_equalTo(coverView.mas_width).multipliedBy(0.4);
            }];
            
            [sameButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(coverView.mas_width).multipliedBy(0.4);
                [make.top.mas_equalTo(diffButton.mas_bottom)setOffset:5];
                make.centerX.mas_equalTo(coverView.mas_centerX);
                make.width.mas_equalTo(coverView.mas_width).multipliedBy(0.4);
            }];
            
            coverView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewRemoveCollCell)];
            [coverView addGestureRecognizer:tap];

        };
        return cell;
    } else {
        DCStoreGridCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCStoreGridCollectionCellID forIndexPath:indexPath];
        cell.storeItem = self.storeItem[indexPath.row];
        _gridCell = cell;
        __weak typeof(cell)weakCell = cell;
        cell.choseMoreBlock = ^(UIImageView *image) {
            
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{ //单列
                coverView = [UIButton buttonWithType:UIButtonTypeCustom];
            });
            coverView.dc_height = weakCell.contentView.dc_height;
            coverView.dc_y = 0;
            coverView.dc_width = weakCell.contentView.dc_width - CGRectGetMaxX(image.frame);
            coverView.dc_x = weakCell.contentView.dc_width;
            [UIView animateWithDuration:0.5 animations:^{
                coverView.dc_x = CGRectGetMaxX(image.frame);
            }];
            
            coverView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
            [weakCell.contentView addSubview:coverView];
            
            diffButton = [[UIButton alloc] init];
            [diffButton setTitle:@"无相同" forState:UIControlStateNormal];
            diffButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [diffButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [diffButton setBackgroundColor:[UIColor redColor]];
            [diffButton addTarget:self action:@selector(GridnoDiff) forControlEvents:UIControlEventTouchUpInside];
            
            sameButton = [[UIButton alloc] init];
            [sameButton setTitle:@"找相似" forState:UIControlStateNormal];
            sameButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [sameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [sameButton setBackgroundColor:[UIColor orangeColor]];
            [sameButton addTarget:self action:@selector(GridlookSame) forControlEvents:UIControlEventTouchUpInside];
            
            nameLabel = [[DCStoreCoverLabel alloc] init];
            nameLabel.text = @"RockectChen直营店";
            
            desLabel = [[DCStoreCoverLabel alloc] init];
            desLabel.text = @"描述 4.9         评论（12）";
            
            serLabel = [[DCStoreCoverLabel alloc] init];
            serLabel.text = @"服务 4.9         有图（4）";
            
            exLabel = [[DCStoreCoverLabel alloc] init];
            exLabel.text = @"物流 4.9         追加（6）";
            
            NSArray *array = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"."];
            [DCSpeedy setSomeOneChangeColor:desLabel SetSelectArray:array SetChangeColor:[UIColor orangeColor]];
            [DCSpeedy setSomeOneChangeColor:serLabel SetSelectArray:array SetChangeColor:[UIColor orangeColor]];
            [DCSpeedy setSomeOneChangeColor:exLabel SetSelectArray:array SetChangeColor:[UIColor orangeColor]];
            
            [coverView addSubview:diffButton];
            [coverView addSubview:sameButton];
            
            [coverView addSubview:nameLabel];
            [coverView addSubview:desLabel];
            [coverView addSubview:serLabel];
            [coverView addSubview:exLabel];
            
            
            [diffButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(coverView).multipliedBy(0.5);
                make.right.mas_equalTo(coverView);
                make.top.mas_equalTo(coverView);
                make.width.mas_equalTo(@(55));
            }];
            
            [sameButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(coverView).multipliedBy(0.5);
                make.right.mas_equalTo(coverView);
                make.top.mas_equalTo(diffButton.mas_bottom);
                make.width.mas_equalTo(@(55));
            }];
            
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                [make.left.mas_equalTo(coverView.mas_left)setOffset:DCMargin];
                [make.right.mas_equalTo(sameButton.mas_left)setOffset:DCMargin];
                [make.top.mas_equalTo(coverView)setOffset:DCMargin];
                
            }];
            
            [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                [make.left.mas_equalTo(coverView.mas_left)setOffset:DCMargin];
                [make.top.mas_equalTo(nameLabel.mas_bottom)setOffset:DCMargin];
                
            }];
            [serLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                [make.left.mas_equalTo(coverView.mas_left)setOffset:DCMargin];
                [make.top.mas_equalTo(desLabel.mas_bottom)setOffset:4];
                
            }];
            [exLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                [make.left.mas_equalTo(coverView.mas_left)setOffset:DCMargin];
                [make.top.mas_equalTo(serLabel.mas_bottom)setOffset:4];
                
            }];
            
            coverView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewRemoveGridCell)];
            [coverView addGestureRecognizer:tap];
        };
        return cell;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCStoreDetailViewController *dcStoreDetailVc = [[DCStoreDetailViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //传商品属性
    dcStoreDetailVc.goodspics = _storeItem[indexPath.row].goodspics;
    dcStoreDetailVc.stockStr = _storeItem[indexPath.row].stock;
    dcStoreDetailVc.shopPrice = _storeItem[indexPath.row].price;
    dcStoreDetailVc.goods_title = _storeItem[indexPath.row].goods_title;
    dcStoreDetailVc.expressage = _storeItem[indexPath.row].expressage;
    dcStoreDetailVc.saleCount = _storeItem[indexPath.row].sale_count;
    dcStoreDetailVc.site = _storeItem[indexPath.row].goods_address;
    
    [self.navigationController pushViewController:dcStoreDetailVc animated:YES];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isGrid) {
        return CGSizeMake((ScreenW - DCMargin)/2.f, _storeItem[indexPath.row].isGardHeight);
    } else {
        return CGSizeMake(ScreenW, _storeItem[indexPath.row].isCellHeight);
    }
}

#pragma mark - 按钮点击
- (void)CollnoDiff
{
    [self coverViewRemoveCollCell];
}

- (void)ColllookSame
{
    [self coverViewRemoveCollCell];
}

- (void)GridnoDiff
{
    [self coverViewRemoveGridCell];
}

- (void)GridlookSame
{
    [self coverViewRemoveGridCell];
}


#pragma mark - 移除视图
- (void)coverViewRemoveGridCell
{
    [UIView animateWithDuration:0.5 animations:^{
        coverView.dc_x = _gridCell.contentView.dc_width;
    } completion:^(BOOL finished) {
        [nameLabel removeFromSuperview];
        [desLabel removeFromSuperview];
        [serLabel removeFromSuperview];
        [exLabel removeFromSuperview];
        [diffButton removeFromSuperview];
        [sameButton removeFromSuperview];
        [coverView removeFromSuperview];
    }];
}

- (void)coverViewRemoveCollCell
{
    [UIView animateWithDuration:0.5 animations:^{
        coverView.dc_height = 0;
        [sameButton removeFromSuperview];
        [diffButton removeFromSuperview];
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
}
@end
