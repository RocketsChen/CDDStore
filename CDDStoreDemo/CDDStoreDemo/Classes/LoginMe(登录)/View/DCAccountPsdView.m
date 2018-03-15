//
//  DCAccountPsdView.m
//  STOExpressDelivery
//
//  Created by 陈甸甸 on 2018/2/6.
//Copyright © 2018年 STO. All rights reserved.
//

#import "DCAccountPsdView.h"

// Controllers
#import "DCHandPickViewController.h"
#import "DCBeautyMessageViewController.h"
#import "DCMediaListViewController.h"
#import "DCBeautyShopViewController.h"
// Models

// Views
#import "UIView+Toast.h"
// Vendors
#import <SVProgressHUD.h>
// Categories

// Others

@interface DCAccountPsdView ()<UITextFieldDelegate>

/* 用户名 */
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
/* 密码 */
@property (weak, nonatomic) IBOutlet UITextField *userPasswordField;
/* 登录 */
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *agreementLabel;

@end

@implementation DCAccountPsdView

#pragma mark - Intial
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUpBase];
}


#pragma mark - initialize
- (void)setUpBase
{
    _loginButton.enabled = NO;
    _loginButton.backgroundColor = [UIColor lightGrayColor];
    [_userNameField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    [_userPasswordField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    _userNameField.text = ([DCObjManager dc_readUserDataForKey:@"UserName"] == nil) ? nil : [DCObjManager dc_readUserDataForKey:@"UserName"];
    
    [DCSpeedy dc_setSomeOneChangeColor:_agreementLabel SetSelectArray:@[@"《",@"》",@"服",@"务",@"协",@"议"] SetChangeColor:RGB(56, 152, 181)];
    
}


- (IBAction)loginAccountClick:(UIButton *)sender {
    
    [self endEditing:YES];
    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    WEAKSELF
    if ([self.userNameField.text isEqualToString:@"CDDMall"] && [self.userPasswordField.text isEqualToString:@"000"]) {
        
        [DCObjManager dc_saveUserData:@"1" forKey:@"isLogin"]; //1代表登录
        [DCObjManager dc_saveUserData:self.userNameField.text forKey:@"UserName"]; //记录用户名

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakSelf makeToast:@"登录成功" duration:0.5 position:CSToastPositionCenter];
            [weakSelf setUpUserBaseData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:^{
                    [weakSelf endEditing:YES];
                    NSLog(@"VC:%@  %@",[[DCSpeedy dc_getCurrentVC] class],[DCHandPickViewController class]);
                    if ([@[[DCHandPickViewController class],[DCBeautyMessageViewController class],[DCMediaListViewController class],[DCBeautyShopViewController class]] containsObject:[[DCSpeedy dc_getCurrentVC] class]]) { //过滤
                        [[NSNotificationCenter defaultCenter]postNotificationName:LOGINSELECTCENTERINDEX object:nil];
                    }
                }];
            });
        });
        
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakSelf makeToast:@"账号密码错误请重新登录" duration:0.5 position:CSToastPositionCenter];
        });
    }
}


#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_userNameField.text.length != 0 && _userPasswordField.text.length != 0) {
        _loginButton.backgroundColor = RGB(252, 159, 149);
        _loginButton.enabled = YES;
    }else{
        _loginButton.backgroundColor = [UIColor lightGrayColor];
        _loginButton.enabled = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}


#pragma mark - 设置初始数据
- (void)setUpUserBaseData
{
    DCUserInfo *userInfo = UserInfoData;
    if (userInfo.username.length == 0) { //userName为指定id不可改动用来判断是否有用户数据
        DCUserInfo *userInfo = [[DCUserInfo alloc] init];
        userInfo.nickname = @"RocketsChen";
        userInfo.sex = @"男";
        userInfo.birthDay = @"1996-02-10";
        userInfo.userimage = @"icon";
        userInfo.username = @"qq-w923740293";
        userInfo.defaultAddress = @"中国 上海";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{//异步保存
            [userInfo saveOrUpdate];
        });
    }
}



#pragma mark - Setter Getter Methods

@end
