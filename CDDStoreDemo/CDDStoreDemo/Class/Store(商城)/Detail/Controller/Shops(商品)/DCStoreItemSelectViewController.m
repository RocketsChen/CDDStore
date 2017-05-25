//
//  DCStoreItemSelectViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreItemSelectViewController.h"

#import "DCStore_attr.h"
#import "DCStore_list.h"

#import "DCStoreHeadPriceCell.h"

#import "DCConsts.h"
#import "WJYAlertView.h"
#import "PPNumberButton.h"
#import "DCStoreAttribute.h"
#import "DCShopItemView.h"
#import "UIView+DCExtension.h"
#import "UIButton+Bootstrap.h"
#import "UIViewController+XWTransition.h"

#import <Masonry.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>

#define currentScreenH 450

@interface DCStoreItemSelectViewController ()<PPNumberButtonDelegate,ShopItemViewDelegate,UITableViewDataSource,UITableViewDelegate>

/* tableView */
@property (nonatomic , strong) UITableView *tableView;

/* 当前弹出屏幕 */
@property (weak ,nonatomic) UIView *shopItemView;
/* 底部按钮 */
@property (weak ,nonatomic) UIButton *bottomButton;
/* 商品图片 */
@property (weak ,nonatomic) UIImageView *iconImageView;
/* 商品中间属性View */
@property (weak ,nonatomic) UIView *middleView;
/** 评论Tag */
@property (nonatomic ,weak) DCShopItemView *attributeView;
/** 评论Tag */
@property (nonatomic ,weak) DCStoreHeadPriceCell *headCell;
/* 数据 */
@property (strong , nonatomic)NSMutableArray <DCStoreAttribute *> *shopAttr;


/** 属性View */
@property (nonatomic ,weak) DCShopItemView *attributeViewAtt01;
@property (nonatomic ,weak) DCShopItemView *attributeViewAtt02;
@property (nonatomic ,weak) DCShopItemView *attributeViewAtt03;
@property (nonatomic ,weak) DCShopItemView *attributeViewAtt04;
@property (nonatomic ,weak) DCShopItemView *attributeViewAtt05;

/* 属性数组 */
@property (nonatomic ,strong) NSMutableArray *array01;
@property (nonatomic ,strong) NSMutableArray *array02;
@property (nonatomic ,strong) NSMutableArray *array03;
@property (nonatomic ,strong) NSMutableArray *array04;
@property (nonatomic ,strong) NSMutableArray *array05;

/* 属性记录名 */
@property (nonatomic ,weak) UILabel *label0;
@property (nonatomic ,weak) UILabel *label1;
@property (nonatomic ,weak) UILabel *label2;
@property (nonatomic ,weak) UILabel *label3;
@property (nonatomic ,weak) UILabel *label4;

/* 商品完整属性 */
@property (weak ,nonatomic) NSString *attFullStr;


@end

/* 变动价格 */
static NSString *plusprice01_;
static NSString *plusprice02_;
static NSString *plusprice03_;
static NSString *plusprice04_;
static NSString *plusprice05_;
static float plusprice_;

static NSString *const DCStoreHeadPriceCellID = @"DCStoreHeadPriceCell";

@implementation DCStoreItemSelectViewController


#pragma mark - 懒加载
- (NSMutableArray<DCStoreAttribute *> *)shopAttr
{
    if (!_shopAttr) {
        _shopAttr = [NSMutableArray array];
    }
    return _shopAttr;
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 100) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpItemSelectAlterView];
    
    [self setUpShopsItemView];
    
    [self setUpMidddleView];
    
    [self setUpTab];
}


- (void)setUpTab
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.tableView.scrollEnabled = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCStoreHeadPriceCell class]) bundle:nil] forCellReuseIdentifier:DCStoreHeadPriceCellID];
}


#pragma mark - 中间视图
- (void)setUpMidddleView
{
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, ScreenW, currentScreenH - 50 - 100 - 60)];
    [self.shopItemView addSubview:middleView];
    _middleView = middleView;

    NSString *bundleResource = ([_iconImage isEqualToString:@"shopImage01"]) ? @"ShopItemA.plist": ([_iconImage isEqualToString:@"shopImage02"]) ? @"ShopItemB.plist" :  @"ShopItemC.plist" ;
    NSArray *storeItemArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:bundleResource ofType:nil]];
    _shopAttr = [DCStoreAttribute mj_objectArrayWithKeyValuesArray:storeItemArray];
    
    [self setUpWithAttriUI];
}

#pragma mark - 商品属性
- (void)setUpWithAttriUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 1)];
    [_middleView addSubview:scrollView];
    UIFont *font = [UIFont systemFontOfSize:14];
    
    _array01 = [NSMutableArray array];
    _array02 = [NSMutableArray array];
    _array03 = [NSMutableArray array];
    _array04 = [NSMutableArray array];
    _array05 = [NSMutableArray array];
    
    NSInteger i;
    //中间属性判断
    if (_shopAttr.count == 5) {//5组数据

        for (i = 0; i < _shopAttr[0].list.count; i++) {
            NSString *tagName = _shopAttr[0].list[i].infoname;
            [_array01 addObject:tagName];
        }
        for (i = 0; i < _shopAttr[1].list.count; i++) {
            NSString *tagName = _shopAttr[1].list[i].infoname;
            [_array02 addObject:tagName];
        }
        for (i = 0; i < _shopAttr[2].list.count; i++) {
            NSString *tagName = _shopAttr[2].list[i].infoname;
            [_array03 addObject:tagName];
        }
        for (i = 0; i < _shopAttr[3].list.count; i++) {
            NSString *tagName = _shopAttr[3].list[i].infoname;
            [_array04 addObject:tagName];
        }
        for (i = 0; i < _shopAttr[4].list.count; i++) {
            NSString *tagName = _shopAttr[4].list[i].infoname;
            [_array05 addObject:tagName];
        }
        DCShopItemView *attributeViewAtt01 = [DCShopItemView attributeViewWithTitle:_shopAttr[0].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array01 viewWidth:ScreenW];
        self.attributeViewAtt01 = attributeViewAtt01;
        
        DCShopItemView *attributeViewAtt02 = [DCShopItemView attributeViewWithTitle:_shopAttr[1].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array02 viewWidth:ScreenW];
        self.attributeViewAtt02 = attributeViewAtt02;
        
        DCShopItemView *attributeViewAtt03 = [DCShopItemView attributeViewWithTitle:_shopAttr[2].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array03 viewWidth:ScreenW];
        self.attributeViewAtt03 = attributeViewAtt03;
        
        DCShopItemView *attributeViewAtt04 = [DCShopItemView attributeViewWithTitle:_shopAttr[3].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array04 viewWidth:ScreenW];
        self.attributeViewAtt04 = attributeViewAtt04;
        
        DCShopItemView *attributeViewAtt05 = [DCShopItemView attributeViewWithTitle:_shopAttr[4].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array05 viewWidth:ScreenW];
        self.attributeViewAtt05 = attributeViewAtt05;
        
        _attributeViewAtt01.dc_y = 0;
        _attributeViewAtt02.dc_y = CGRectGetMaxY(_attributeViewAtt01.frame) + DCMargin;
        _attributeViewAtt03.dc_y = CGRectGetMaxY(_attributeViewAtt02.frame) + DCMargin;
        _attributeViewAtt04.dc_y = CGRectGetMaxY(_attributeViewAtt03.frame) + DCMargin;
        _attributeViewAtt05.dc_y = CGRectGetMaxY(_attributeViewAtt04.frame) + DCMargin;

        // 添加到scrollview上
        [scrollView addSubview:_attributeViewAtt01];
        [scrollView addSubview:_attributeViewAtt02];
        [scrollView addSubview:_attributeViewAtt03];
        [scrollView addSubview:_attributeViewAtt04];
        [scrollView addSubview:_attributeViewAtt05];
        
        scrollView.contentSize = (CGSize){0,_attributeViewAtt05.dc_bottom};
        
    }else if (_shopAttr.count == 4){//4组数据

        for (i = 0; i < _shopAttr[0].list.count; i++) {
            NSString *tagName = _shopAttr[0].list[i].infoname;
            [_array01 addObject:tagName];
        }
        for (i = 0; i < _shopAttr[1].list.count; i++) {
            NSString *tagName = _shopAttr[1].list[i].infoname;
            [_array02 addObject:tagName];
        }
        for (i = 0; i < _shopAttr[2].list.count; i++) {
            NSString *tagName = _shopAttr[2].list[i].infoname;
            [_array03 addObject:tagName];
        }
        for (i = 0; i < _shopAttr[3].list.count; i++) {
            NSString *tagName = _shopAttr[3].list[i].infoname;
            [_array04 addObject:tagName];
        }
        
        DCShopItemView *attributeViewAtt01 = [DCShopItemView attributeViewWithTitle:_shopAttr[0].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array01 viewWidth:ScreenW];
        self.attributeViewAtt01 = attributeViewAtt01;
        
        DCShopItemView *attributeViewAtt02 = [DCShopItemView attributeViewWithTitle:_shopAttr[1].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array02 viewWidth:ScreenW];
        self.attributeViewAtt02 = attributeViewAtt02;
        
        DCShopItemView *attributeViewAtt03 = [DCShopItemView attributeViewWithTitle:_shopAttr[2].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array03 viewWidth:ScreenW];
        self.attributeViewAtt03 = attributeViewAtt03;
        
        DCShopItemView *attributeViewAtt04 = [DCShopItemView attributeViewWithTitle:_shopAttr[3].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array04 viewWidth:ScreenW];
        self.attributeViewAtt04 = attributeViewAtt04;
        
        _attributeViewAtt01.dc_y = 0;
        _attributeViewAtt02.dc_y = CGRectGetMaxY(_attributeViewAtt01.frame) + DCMargin;
        _attributeViewAtt03.dc_y = CGRectGetMaxY(_attributeViewAtt02.frame) + DCMargin;
        _attributeViewAtt04.dc_y = CGRectGetMaxY(_attributeViewAtt03.frame) + DCMargin;

        // 添加到scrollview上
        [scrollView addSubview:_attributeViewAtt01];
        [scrollView addSubview:_attributeViewAtt02];
        [scrollView addSubview:_attributeViewAtt03];
        [scrollView addSubview:_attributeViewAtt04];
        
        scrollView.contentSize = (CGSize){0,_attributeViewAtt04.dc_bottom};
        
    }else if (_shopAttr.count == 3){//3组数据

        for (i = 0; i < _shopAttr[0].list.count; i++) {
            NSString *tagName = _shopAttr[0].list[i].infoname;
            [_array01 addObject:tagName];
        }
        for (i = 0; i < _shopAttr[1].list.count; i++) {
            NSString *tagName = _shopAttr[1].list[i].infoname;
            [_array02 addObject:tagName];
        }
        for (i = 0; i < _shopAttr[2].list.count; i++) {
            NSString *tagName = _shopAttr[2].list[i].infoname;
            [_array03 addObject:tagName];
        }
        DCShopItemView *attributeViewAtt01 = [DCShopItemView attributeViewWithTitle:_shopAttr[0].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array01 viewWidth:ScreenW];
        self.attributeViewAtt01 = attributeViewAtt01;
        
        DCShopItemView *attributeViewAtt02 = [DCShopItemView attributeViewWithTitle:_shopAttr[1].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array02 viewWidth:ScreenW];
        self.attributeViewAtt02 = attributeViewAtt02;
        
        DCShopItemView *attributeViewAtt03 = [DCShopItemView attributeViewWithTitle:_shopAttr[2].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array03 viewWidth:ScreenW];
        self.attributeViewAtt03 = attributeViewAtt03;

        // 添加到scrollview上
        [scrollView addSubview:_attributeViewAtt01];
        [scrollView addSubview:_attributeViewAtt02];
        [scrollView addSubview:_attributeViewAtt03];
        
        _attributeViewAtt01.dc_y = 0;
        _attributeViewAtt02.dc_y = CGRectGetMaxY(_attributeViewAtt01.frame) + DCMargin;
        _attributeViewAtt03.dc_y = CGRectGetMaxY(_attributeViewAtt02.frame) + DCMargin;
        
        scrollView.contentSize = (CGSize){0,_attributeViewAtt03.dc_bottom};
        
    }else if (_shopAttr.count == 2){//2组数据

        for (i = 0; i < _shopAttr[0].list.count; i++) {
            NSString *tagName = _shopAttr[0].list[i].infoname;
            [_array01 addObject:tagName];
        }
        for (NSInteger i = 0; i < _shopAttr[1].list.count; i++) {
            NSString *tagName = _shopAttr[1].list[i].infoname;
            [_array02 addObject:tagName];
        }
        
        DCShopItemView *attributeViewAtt01 = [DCShopItemView attributeViewWithTitle:_shopAttr[0].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array01 viewWidth:ScreenW];
        self.attributeViewAtt01 = attributeViewAtt01;
        
        DCShopItemView *attributeViewAtt02 = [DCShopItemView attributeViewWithTitle:_shopAttr[1].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array02 viewWidth:ScreenW];
        self.attributeViewAtt02 = attributeViewAtt02;
        // 添加到scrollview上
        [scrollView addSubview:_attributeViewAtt01];
        [scrollView addSubview:_attributeViewAtt02];
        
        // 添加scrollview到当前view上
        [_middleView addSubview:scrollView];
        
        _attributeViewAtt01.dc_y = 0;
        _attributeViewAtt02.dc_y = CGRectGetMaxY(_attributeViewAtt01.frame) + DCMargin;
        
        scrollView.contentSize = (CGSize){0,_attributeViewAtt03.dc_bottom};
        
    }else if (_shopAttr.count == 1){//1组数据

        for (i = 0; i < _shopAttr[0].list.count; i++) {
            NSString *tagName = _shopAttr[0].list[i].infoname;
            [_array01 addObject:tagName];
        }
        
        DCShopItemView *attributeViewAtt01 = [DCShopItemView attributeViewWithTitle:_shopAttr[0].attr.attrname titleFont:font titleColor:[UIColor blackColor] WithBtnBgColor:DCRGBColor(229, 229, 229) titleNormalColor:DCRGBColor(100, 100, 100) titleSelectColor:[UIColor whiteColor] WithButtonCornerRadius:3 attributeTexts:_array01 viewWidth:ScreenW];
        self.attributeViewAtt01 = attributeViewAtt01;

        // 添加到scrollview上
        [scrollView addSubview:_attributeViewAtt01];
        
        _attributeViewAtt01.dc_y = 0;
        
        scrollView.contentSize = (CGSize){0,_attributeViewAtt01.dc_bottom};
    }
    
    
    // 设置代理
    _attributeViewAtt01.ShopItem_delegate = self;
    _attributeViewAtt02.ShopItem_delegate = self;
    _attributeViewAtt03.ShopItem_delegate = self;
    _attributeViewAtt04.ShopItem_delegate = self;
    _attributeViewAtt05.ShopItem_delegate = self;
    
    // 添加scrollview到当前view上
    [_middleView addSubview:scrollView];
    // 通过动画设置scrollview的高度, 也可以一开始就设置好
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        scrollView.dc_height += currentScreenH - 50 - 100 - 60;
    } completion:nil];
    
}

#pragma mark - AttributeViewDelegate
- (void)ShopItem_View:(DCShopItemView *)view didClickBtn:(UIButton *)btn{
    NSString *title = btn.titleLabel.text;
    [self.tableView reloadData];
    if (!btn.selected) {
        self.label0.text = nil;
        self.label1.text = nil;
        self.label2.text = nil;
        self.label3.text = nil;
        self.label4.text = nil;
    }
    NSInteger i;
    if ([view isEqual:self.attributeViewAtt01]) {
        self.label0.text = title;
        for (i = 0; i < _array01.count; i++) {
            if ([_array01[i] isEqualToString:title]) {
                plusprice01_ = _shopAttr[0].list[i].plusprice;
            }
        }
    }else if ([view isEqual:self.attributeViewAtt02]){
        self.label1.text = title;
        for (i = 0; i < _array02.count; i++) {
            if ([_array02[i] isEqualToString:title]) {
                plusprice02_ = _shopAttr[1].list[i].plusprice;
            }
        }
    }else if ([view isEqual:self.attributeViewAtt03]){
        self.label2.text = title;
        for (i = 0; i < _array03.count; i++) {
            if ([_array03[i] isEqualToString:title]) {
                plusprice03_ = _shopAttr[2].list[i].plusprice;
            }
        }
    }else if ([view isEqual:self.attributeViewAtt04]){
        self.label3.text = title;
        for (i = 0; i < _array04.count; i++) {
            if ([_array04[i] isEqualToString:title]) {
                plusprice04_ = _shopAttr[3].list[i].plusprice;
            }
        }
    }else if ([view isEqual:self.attributeViewAtt04]){
        self.label4.text = title;
        for (i = 0; i < _array05.count; i++) {
            if ([_array05[i] isEqualToString:title]) {
                plusprice05_ = _shopAttr[4].list[i].plusprice;
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCStoreHeadPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:DCStoreHeadPriceCellID forIndexPath:indexPath];
    _headCell = cell;
    cell.icoImageView.image = [UIImage imageNamed:_iconImage];
    
    _iconImageView = cell.icoImageView;
    
    NSInteger price01 = (plusprice01_.length != 0) ? [plusprice01_ intValue] : 0;
    NSInteger price02 = (plusprice02_.length != 0) ? [plusprice02_ intValue] : 0;
    NSInteger price03 = (plusprice03_.length != 0) ? [plusprice03_ intValue] : 0;
    NSInteger price04 = (plusprice04_.length != 0) ? [plusprice04_ intValue] : 0;
    NSInteger price05 = (plusprice05_.length != 0) ? [plusprice05_ intValue] : 0;
    
    plusprice_ = price01 + price02 + price03 + price04 + price05;
    cell.priceLabel.text = [NSString stringWithFormat:@"¥ %0.2f",[_money floatValue] + plusprice_];
    cell.repertoryLabel.text = [NSString stringWithFormat:@"库存%@件",_stock];
    
    cell.attributeLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",(![self.label0.text isEqualToString:@"商品属性"])? @"已选择:" :@"请选择:",(self.label0.text.length != 0) ? self.label0.text : @"",(self.label1.text.length != 0) ? self.label1.text : @"",(self.label2.text.length != 0) ? self.label2.text : @"" ,(self.label3.text.length != 0) ? self.label3.text : @"" ,(self.label4.text.length != 0) ? self.label4.text : @"" ];
    
    __weak typeof(self)weakSelf = self;
    cell.dismissButtonClickBlock = ^(){
        [weakSelf selfViewBack];
    };
    return cell;
}


#pragma mark - 商品View
- (void)setUpShopsItemView
{
    UIView *shopItemView = [[UIView alloc] init];
    shopItemView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shopItemView];
    
    shopItemView.frame = CGRectMake(0, 0, ScreenW, currentScreenH);
    
    _shopItemView = shopItemView;
    
    [self setUpHeadView];
    
    [self setUpBottmView];
}

#pragma mark - 顶部View
- (void)setUpHeadView
{
    UIView *shopHeadView = [[UIView alloc] init];
    [self.shopItemView addSubview:shopHeadView];
    
    [shopHeadView addSubview:_tableView];
    
    UILabel *label0 = [[UILabel alloc] init];
    [shopHeadView addSubview:label0];
    self.label0 = label0;
    self.label0.text = @"商品属性";
    
    UILabel *label1 = [[UILabel alloc] init];
    [shopHeadView addSubview:label1];
    self.label1 = label1;
    
    UILabel *label2 = [[UILabel alloc] init];
    [shopHeadView addSubview:label2];
    self.label2 = label2;
    
    UILabel *label3 = [[UILabel alloc] init];
    [shopHeadView addSubview:label3];
    self.label3 = label3;
    
    UILabel *label4 = [[UILabel alloc] init];
    [shopHeadView addSubview:label4];
    self.label4 = label4;
    
    label0.font = label1.font = label2.font = label3.font = label4.font = [UIFont systemFontOfSize:14];
}

#pragma mark - 底部View
- (void)setUpBottmView
{
    NSArray *titles = @[@"加入购物车",@"立刻购买"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? [UIColor orangeColor] : [UIColor redColor];
        button.tag = i;
        _bottomButton = button;
        [button addTarget:self action:@selector(buyItButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.shopItemView addSubview:button];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        
        
        if (button.tag == 0) {
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(50));
                make.left.mas_equalTo(self.shopItemView.mas_left);
                make.bottom.mas_equalTo(self.shopItemView.mas_bottom);
                make.width.mas_equalTo(self.shopItemView.mas_width).multipliedBy(0.5);
            }];
        }else{
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(50));
                make.right.mas_equalTo(self.shopItemView.mas_right);
                make.bottom.mas_equalTo(self.shopItemView.mas_bottom);
                make.width.mas_equalTo(self.shopItemView.mas_width).multipliedBy(0.5);
            }];
        }
    }
    //计数器
    UIView *buyNumView = [[UIView alloc] init];
    [self.shopItemView addSubview:buyNumView];
    
    UILabel *buyCountLabel = [[UILabel alloc] init];
    buyCountLabel.text = @"购买数量";
    buyCountLabel.font = [UIFont systemFontOfSize:16];
    [buyNumView addSubview:buyCountLabel];
    
    UILabel *buyMarkLabel = [[UILabel alloc] init];
    buyMarkLabel.text = @"(部分商品限购一件)";
    buyMarkLabel.font = [UIFont systemFontOfSize:14];
    buyMarkLabel.textColor = [UIColor darkGrayColor];
    [buyNumView addSubview:buyMarkLabel];
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(ScreenW - (110 + DCMargin), 15, 110, 30)];
    // 开启抖动动画
    numberButton.shakeAnimation = YES;
    // 设置最小值
    numberButton.minValue = 1;
    // 设置输入框中的字体大小
    numberButton.inputFieldFont = 23;
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    numberButton.currentNumber = 1;
    numberButton.delegate = self;
    
    numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        _buyNum = num;
    };
    [buyNumView addSubview:numberButton];
    
    
    //约束
    [buyNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(60));
        make.right.mas_equalTo(self.shopItemView.mas_right);
        make.width.mas_equalTo(self.shopItemView.mas_width);
        [make.top.mas_equalTo(self.shopItemView.mas_bottom)setOffset:-110];
    }];
    
    [buyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(70));
        [make.left.mas_equalTo(buyNumView.mas_left)setOffset:DCMargin];
        make.bottom.mas_equalTo(buyNumView.mas_bottom);
        make.height.mas_equalTo(buyNumView.mas_height);
    }];

    [buyMarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(140));
        [make.left.mas_equalTo(buyCountLabel.mas_right)setOffset:DCMargin * 0.5];
        make.centerY.mas_equalTo(buyCountLabel.mas_centerY);
        make.height.mas_equalTo(buyCountLabel.mas_height);
    }];

}

#pragma mark - 弹出弹框
- (void)setUpItemSelectAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    __weak typeof(self)weakSelf = self;
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf selfViewBack];
    } edgeSpacing:0];
}

#pragma mark - 退出当前View
- (void)selfViewBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 立即购买和加入购物车按钮点击事件
- (void)buyItButtonClick:(UIButton *)button
{
    __weak typeof(self)weakSelf = self;
    if (button.tag == 1) {//立即购买
        [self cancelWithChoseItemBlock:^{
            [weakSelf buyItNow];
        }];
    }else{//加入购物车
        
        [self cancelWithChoseItemBlock:^{
            [weakSelf addShopCar];
        }];
    }
    
}

#pragma mark - 立即购买
- (void)buyItNow
{
    NSLog(@"点击了立即购买");
    NSString *num = (_buyNum < 1)? @"1" : [NSString stringWithFormat:@"%zd",_buyNum];
    _attFullStr = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",(self.label0.text.length != 0) ? self.label0.text : @"",(self.label1.text.length != 0) ? self.label1.text : @"",(self.label2.text.length != 0) ? self.label2.text : @"" ,(self.label3.text.length != 0) ? self.label3.text : @"" ,(self.label4.text.length != 0) ? self.label4.text : @"" ];
    
    NSString * chosePrice = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2f",plusprice_ + [_money floatValue]]];
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:num,@"shopNum",_attFullStr,@"attFullStr",chosePrice,@"choseprice", nil];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:DCBuyButtonDidDismissClickNotificationCenter object:nil userInfo:dict];
    }];
}

#pragma mark - 添加购物车
- (void)addShopCar
{

    [self addShopCarAnimal];
    NSLog(@"点击了添加购物车");
}


#pragma mark - 判断选择
- (void)cancelWithChoseItemBlock:(void(^)())choseSussessBlock
{
    if ((_shopAttr.count == 2 && _label1.text.length == 0) || [_label0.text isEqualToString:@"商品属性"]) {
        [SVProgressHUD showInfoWithStatus:@"请选择商品属性"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }else if((_shopAttr.count == 3 && _label2.text.length == 0)  ||  (_label1.text.length == 0 && [_label0.text isEqualToString:@"商品属性"])) {
        [SVProgressHUD showInfoWithStatus:@"请选择商品属性"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }else if((_shopAttr.count == 4 && _label3.text.length == 0 )|| (_label2.text.length == 0 &&  _label1.text.length == 0 && [_label0.text isEqualToString:@"商品属性"])){
        [SVProgressHUD showInfoWithStatus:@"请选择商品属性"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }else if ((_shopAttr.count == 5 && _label4.text.length == 0 )|| (_label3.text.length == 0 && _label2.text.length == 0 &&  _label1.text.length == 0 && [_label0.text isEqualToString:@"商品属性"])){
        [SVProgressHUD showInfoWithStatus:@"请选择商品属性"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }else{
        !choseSussessBlock ? : choseSussessBlock();
    }

}

#pragma mark - 添加购物车动画
- (void)addShopCarAnimal
{
    UIImageView *anImage = [[UIImageView alloc]initWithFrame:_iconImageView.bounds];
    anImage.image = _iconImageView.image;
    [_headCell addSubview:anImage];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 15];
    rotationAnimation.duration = 1.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 0;
    
    // 让旋转动画慢于缩放动画执行
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [anImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    });
    
    [UIView animateWithDuration:1.0 animations:^{
        anImage.frame = CGRectMake(weakSelf.view.frame.size.width - 55, - (weakSelf.view.frame.size.height - CGRectGetHeight(weakSelf.view.frame) - 40), 0, 0);
    } completion:^(BOOL finished) {
        
        // 动画完成后弹框消失
        [weakSelf selfViewBack];

    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 属性数组
- (NSMutableArray *)array01
{
    if (!_array01) {
        _array01 = [NSMutableArray array];
    }
    return _array01;
}
- (NSMutableArray *)array02
{
    if (!_array02) {
        _array02 = [NSMutableArray array];
    }
    return _array02;
}
- (NSMutableArray *)array03
{
    if (!_array03) {
        _array03 = [NSMutableArray array];
    }
    return _array03;
}
- (NSMutableArray *)array04
{
    if (!_array04) {
        _array04 = [NSMutableArray array];
    }
    return _array04;
}
- (NSMutableArray *)array05
{
    if (!_array05) {
        _array05 = [NSMutableArray array];
    }
    return _array05;
}


@end
