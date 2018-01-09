//
//  DCCommodityViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define tableViewH  95

#import "DCCommodityViewController.h"

// Controllers
#import "DCGoodsSetViewController.h"
// Models
#import "DCClassMianItem.h"
#import "DCCalssSubItem.h"
#import "DCClassGoodsItem.h"
// Views
#import "DCNavSearchBarView.h"
#import "DCClassCategoryCell.h"
#import "DCGoodsSortCell.h"
#import "DCBrandSortCell.h"
#import "DCBrandsSortHeadView.h"
// Vendors
#import <MJExtension.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others

@interface DCCommodityViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* collectionViw */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;
/* 语音按钮 */
@property (strong , nonatomic)UIButton *voiceButton;
/* 左边数据 */
@property (strong , nonatomic)NSMutableArray<DCClassGoodsItem *> *titleItem;
/* 右边数据 */
@property (strong , nonatomic)NSMutableArray<DCClassMianItem *> *mainItem;

@end

static NSString *const DCClassCategoryCellID = @"DCClassCategoryCell";
static NSString *const DCBrandsSortHeadViewID = @"DCBrandsSortHeadView";
static NSString *const DCGoodsSortCellID = @"DCGoodsSortCell";
static NSString *const DCBrandSortCellID = @"DCBrandSortCell";

@implementation DCCommodityViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, DCTopNavH, tableViewH, ScreenH - DCTopNavH);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[DCClassCategoryCell class] forCellReuseIdentifier:DCClassCategoryCellID];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 3; //X
        layout.minimumLineSpacing = 5;  //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(tableViewH + 5, DCTopNavH, ScreenW - tableViewH - DCMargin, ScreenH - DCTopNavH);
        //注册Cell
        [_collectionView registerClass:[DCGoodsSortCell class] forCellWithReuseIdentifier:DCGoodsSortCellID];
        [_collectionView registerClass:[DCBrandSortCell class] forCellWithReuseIdentifier:DCBrandSortCellID];
        //注册Header
        [_collectionView registerClass:[DCBrandsSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID];
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpTab];
    
    [self setUpData];
}

#pragma mark - initizlize
- (void)setUpTab
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - 加载数据
- (void)setUpData
{
    _titleItem = [DCClassGoodsItem mj_objectArrayWithFilename:@"ClassifyTitles.plist"];
    _mainItem = [DCClassMianItem mj_objectArrayWithFilename:@"ClassiftyGoods01.plist"];
    //默认选择第一行（注意一定要在加载完数据之后）
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}


#pragma mark - 设置导航条
- (void)setUpNav
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"mshop_message_gray_icon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"mshop_message_gray_icon"] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(messButtonBarItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, backButton];
    
    _topSearchView = [[UIView alloc] init];
    _topSearchView.backgroundColor = RGBA(240, 240, 240, 1);
    _topSearchView.layer.cornerRadius = 16;
    [_topSearchView.layer masksToBounds];
    _topSearchView.frame = CGRectMake(50, 6, ScreenW - 110, 32);
    self.navigationItem.titleView = _topSearchView;
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"搜索商品/店铺" forState:0];
    [_searchButton setTitleColor:[UIColor lightGrayColor] forState:0];
    _searchButton.titleLabel.font = PFR13Font;
    [_searchButton setImage:[UIImage imageNamed:@"group_home_search_gray"] forState:0];
    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * DCMargin, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, DCMargin, 0, 0);
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _searchButton.frame = CGRectMake(0, 0, _topSearchView.dc_width - 2 * DCMargin, _topSearchView.dc_height);
    [_topSearchView addSubview:_searchButton];
    
    
    _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _voiceButton.adjustsImageWhenHighlighted = NO;
    _voiceButton.frame = CGRectMake(_topSearchView.dc_width - 40, 0, 35, _topSearchView.dc_height);
    [_voiceButton addTarget:self action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_voiceButton setImage:[UIImage imageNamed:@"icon_voice_search"] forState:0];
    [_topSearchView addSubview:_voiceButton];
    
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:DCClassCategoryCellID forIndexPath:indexPath];
    cell.titleItem = _titleItem[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _mainItem = [DCClassMianItem mj_objectArrayWithFilename:_titleItem[indexPath.row].fileName];
    [self.collectionView reloadData];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _mainItem.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mainItem[section].goods.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if ([_mainItem[_mainItem.count - 1].title isEqualToString:@"热门品牌"]) {
        if (indexPath.section == _mainItem.count - 1) {//品牌
            DCBrandSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCBrandSortCellID forIndexPath:indexPath];
            cell.subItem = _mainItem[indexPath.section].goods[indexPath.row];
            gridcell = cell;
        }
        else {//商品
            DCGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsSortCellID forIndexPath:indexPath];
            cell.subItem = _mainItem[indexPath.section].goods[indexPath.row];
            gridcell = cell;
        }
    }else{//商品
        DCGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsSortCellID forIndexPath:indexPath];
        cell.subItem = _mainItem[indexPath.section].goods[indexPath.row];
        gridcell = cell;
    }

    return gridcell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        DCBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID forIndexPath:indexPath];
        headerView.headTitle = _mainItem[indexPath.section];
        reusableview = headerView;
    }
    return reusableview;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        if ([_mainItem[_mainItem.count - 1].title isEqualToString:@"热门品牌"]) {
            if (indexPath.section == _mainItem.count - 1) {//品牌
                return CGSizeMake((ScreenW - tableViewH - 6 - DCMargin)/3, 60);
            }else{//商品
                return CGSizeMake((ScreenW - tableViewH - 6 - DCMargin)/3, (ScreenW - tableViewH - 6 - DCMargin)/3 + 20);
            }
        }else{
            return CGSizeMake((ScreenW - tableViewH - 6 - DCMargin)/3, (ScreenW - tableViewH - 6 - DCMargin)/3 + 20);
        }
    return CGSizeZero;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenW, 25);
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了个第%zd分组第%zd几个Item",indexPath.section,indexPath.row);
    DCGoodsSetViewController *goodSetVc = [[DCGoodsSetViewController alloc] init];
    goodSetVc.goodPlisName = @"ClasiftyGoods.plist";
    [self.navigationController pushViewController:goodSetVc animated:YES];
}


#pragma mark - 搜索点击
- (void)searchButtonClick
{
    
}

#pragma mark - 语音点击
- (void)voiceButtonClick
{
    
}

#pragma mark - 消息点击
- (void)messButtonBarItemClick
{
    
}

@end
