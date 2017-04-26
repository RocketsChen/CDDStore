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

@end

static NSString *DCStoreCollectionViewCellID = @"DCStoreCollectionViewCell";
static NSString *DCStoreGridCollectionCellID = @"DCStoreGridCollectionCell";

@implementation DCStoreCollectionViewController

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
        cell.storeItem = self.storeItem[indexPath.row];
        cell.choseBlock = ^(){};
        return cell;
    } else {
        DCStoreGridCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCStoreGridCollectionCellID forIndexPath:indexPath];
        cell.storeItem = self.storeItem[indexPath.row];
        cell.choseBlock = ^(){};
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

@end
