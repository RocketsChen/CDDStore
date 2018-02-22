//
//  DCNewAdressViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/19.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCNewAdressViewController.h"

// Controllers

// Models
#import "DCAdressDateBase.h"
#import "DCAdressItem.h"
// Views
#import "DCNewAdressView.h"
// Vendors
#import "UIView+Toast.h"
#import <SVProgressHUD.h>
#import "ChooseLocationView.h"
#import "CitiesDataTool.h"
// Categories

// Others
#import "DCCheckRegular.h"

@interface DCNewAdressViewController ()<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UIGestureRecognizerDelegate>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
@property (nonatomic,strong) ChooseLocationView *chooseLocationView;
@property (nonatomic,strong) UIView  *cover;
/* headView */
@property (strong , nonatomic)DCNewAdressView *adressHeadView;
@property (weak, nonatomic) IBOutlet UIButton *saveChangeButton;

@end

@implementation DCNewAdressViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.frame = CGRectMake(0, DCTopNavH + 20, ScreenW, ScreenH - (DCTopNavH + 20 + 45));
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
    }
    return _tableView;
}


#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpHeadView];
}

- (void)setUpBase
{
    self.title = (_saveType == DCSaveAdressNewType) ? @"新增收货人地址" : @"编辑收货人地址";
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = self.view.backgroundColor;

    [[CitiesDataTool sharedManager] requestGetData];
    [self.view addSubview:self.cover];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"保存" forState:0];
    button.frame = CGRectMake(0, 0, 44, 44);
    button.titleLabel.font = PFR16Font;
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:self action:@selector(saveButtonBarItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, backButton];
}


#pragma mark - 头部View
- (void)setUpHeadView
{
    _adressHeadView = [DCNewAdressView dc_viewFromXib];
    _adressHeadView.frame = CGRectMake(0, 0, ScreenW, 210);
    
    self.tableView.tableHeaderView = _adressHeadView;
    self.tableView.tableFooterView = [UIView new];
    
    if (_saveType == DCSaveAdressChangeType) { //编辑
        _adressHeadView.rePersonField.text = _adressItem.userName;
        _adressHeadView.addressLabel.text = _adressItem.chooseAdress;
        _adressHeadView.rePhoneField.text = _adressItem.userPhone;
        _adressHeadView.detailTextView.text = _adressItem.userAdress;
        
    }else if (_saveType == DCSaveAdressNewType && [DCObjManager dc_readUserDataForKey:@"StoreAddress"] != nil){
        
        NSArray *storeAddress = [DCObjManager dc_readUserDataForKey:@"StoreAddress"];
        _adressHeadView.rePersonField.text = storeAddress[0];
        _adressHeadView.rePhoneField.text = storeAddress[1];
        _adressHeadView.addressLabel.text = storeAddress[2];
        _adressHeadView.detailTextView.text = storeAddress[3];
    }
    
    WEAKSELF
    _adressHeadView.selectAdBlock = ^{
        [weakSelf.view endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.cover.hidden = !weakSelf.cover.hidden;
            weakSelf.chooseLocationView.hidden = weakSelf.cover.hidden;
        });
    };
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - 保存新地址
- (IBAction)saveNewAdressClick {
    
    if (_adressHeadView.rePersonField.text.length == 0 || _adressHeadView.rePhoneField.text.length == 0 || _adressHeadView.detailTextView.text.length == 0 || _adressHeadView.addressLabel.text.length == 0) {
        [self.view makeToast:@"请填写完整地址信息" duration:0.5 position:CSToastPositionCenter];
        [DCSpeedy dc_callFeedback]; //触动
        return;
    }

    if (![DCCheckRegular dc_checkTelNumber:_adressHeadView.rePhoneField.text]) {
        [self.view makeToast:@"手机号码格式错误" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    DCAdressItem *adressItem =  (_saveType == DCSaveAdressNewType) ? [DCAdressItem new] : _adressItem;
    adressItem.userName = _adressHeadView.rePersonField.text;
    adressItem.userPhone = _adressHeadView.rePhoneField.text;
    adressItem.userAdress = _adressHeadView.detailTextView.text;
    adressItem.chooseAdress = _adressHeadView.addressLabel.text;
    adressItem.isDefault = @"1"; // 默认不选择
    if (_saveType == DCSaveAdressNewType) { //新建
        [[DCAdressDateBase sharedDataBase]addNewAdress:adressItem];
        
    }else if (_saveType == DCSaveAdressChangeType){ //更新
        
        [[DCAdressDateBase sharedDataBase]updateAdress:adressItem];
    }

    WEAKSELF
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [weakSelf.view makeToast:@"保存成功" duration:0.5 position:CSToastPositionCenter];
        [DCObjManager dc_removeUserDataForkey:@"StoreAddress"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpDateUI" object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    });
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (CGRectContainsPoint(_chooseLocationView.frame, point)){
        return NO;
    }
    return YES;
}


- (void)tapCover:(UITapGestureRecognizer *)tap{
    
    if (_chooseLocationView.chooseFinish) {
        _chooseLocationView.chooseFinish();
    }
}

- (ChooseLocationView *)chooseLocationView{
    
    if (!_chooseLocationView) {
        _chooseLocationView = [[ChooseLocationView alloc]initWithFrame:CGRectMake(0, ScreenH - 350, ScreenW, 350)];
        
    }
    return _chooseLocationView;
}

- (UIView *)cover{
    
    if (!_cover) {
        _cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [_cover addSubview:self.chooseLocationView];
        __weak typeof (self) weakSelf = self;
        _chooseLocationView.chooseFinish = ^{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.adressHeadView.addressLabel.text = weakSelf.chooseLocationView.address;
                weakSelf.cover.hidden = YES;
            }];
        };
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCover:)];
        [_cover addGestureRecognizer:tap];
        tap.delegate = self;
        _cover.hidden = YES;
    }
    return _cover;
}

#pragma mark - 点击保存
- (void)saveButtonBarItemClick
{
    [self.view endEditing:YES];
    
    if (_adressHeadView.rePersonField.text.length == 0 && _adressHeadView.rePhoneField.text.length == 0 && _adressHeadView.addressLabel.text.length == 0 && _adressHeadView.detailTextView.text.length == 0) {
        [self.view makeToast:@"当前编辑为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    NSString *adress = (_adressHeadView.addressLabel.text == nil) ? @"" : _adressHeadView.addressLabel.text; //取空
    NSArray *storeAddress = @[_adressHeadView.rePersonField.text,_adressHeadView.rePhoneField.text,adress,_adressHeadView.detailTextView.text];
    [DCObjManager dc_saveUserData:storeAddress forKey:@"StoreAddress"];
    [self.view makeToast:@"保存成功" duration:0.5 position:CSToastPositionCenter];
}

@end
