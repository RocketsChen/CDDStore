//
//  DCDetailOverFooterView.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCDetailOverFooterView.h"

// Controllers

// Models

// Views
#import "DCLIRLButton.h"
// Vendors

// Categories

// Others

@interface DCDetailOverFooterView ()

/* 底部上拉提示 */
@property (strong , nonatomic)DCLIRLButton *overMarkButton;

@end

@implementation DCDetailOverFooterView

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
    self.backgroundColor = DCBGColor;
    _overMarkButton = [DCLIRLButton buttonWithType:UIButtonTypeCustom];
    [_overMarkButton setImage:[UIImage imageNamed:@"Details_Btn_Up"] forState:UIControlStateNormal];
    [_overMarkButton setTitle:@"上拉查看图文详情" forState:UIControlStateNormal];
    _overMarkButton.titleLabel.font = PFR12Font;
    [_overMarkButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self addSubview:_overMarkButton];
    
    _overMarkButton.frame = CGRectMake(0, 0, self.dc_width, self.dc_height);
}

#pragma mark - Setter Getter Methods


@end
