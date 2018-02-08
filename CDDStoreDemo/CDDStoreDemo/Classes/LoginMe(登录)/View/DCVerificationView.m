//
//  DCVerificationView.m
//  STOExpressDelivery
//
//  Created by 陈甸甸 on 2018/2/6.
//Copyright © 2018年 STO. All rights reserved.
//

#import "DCVerificationView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCVerificationView ()<UITextFieldDelegate>

/* 用户名 */
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
/* 验证码 */
@property (weak, nonatomic) IBOutlet UITextField *verificationField;
/* 验证码按钮 */
@property (weak, nonatomic) IBOutlet UIButton *verificationButton;

@end

@implementation DCVerificationView

#pragma mark - Intial
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUpBase];
}


#pragma mark - initialize
- (void)setUpBase
{
    _loginButton.enabled = _verificationButton.enabled = NO;
    _loginButton.backgroundColor = _verificationButton.backgroundColor =[UIColor lightGrayColor];
    [_userNameField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    [_verificationField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    [DCSpeedy dc_setSomeOneChangeColor:_agreementLabel SetSelectArray:@[@"《",@"》",@"服",@"务",@"协",@"议"] SetChangeColor:RGB(56, 152, 181)];
}


#pragma mark - Setter Getter Methods


#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_userNameField.text.length != 0) {
        _verificationButton.backgroundColor = RGB(252, 159, 149);
        _verificationButton.enabled = YES;
    }else{
        _verificationButton.backgroundColor = [UIColor lightGrayColor];
        [_verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verificationButton.enabled = NO;
    }
    
    if (_userNameField.text.length != 0 && _verificationField.text.length != 0) {
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


#pragma mark - 验证点击
- (IBAction)validationClick:(UIButton *)sender {
    
    __block NSInteger time = 59; //设置倒计时时间
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    WEAKSELF
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [weakSelf.verificationButton setTitle:@"重新发送" forState:UIControlStateNormal];
                weakSelf.verificationButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            NSInteger seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [weakSelf.verificationButton setTitle:[NSString stringWithFormat:@"重新发送(%.2ld)", (long)seconds] forState:UIControlStateNormal];
                weakSelf.verificationButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end
