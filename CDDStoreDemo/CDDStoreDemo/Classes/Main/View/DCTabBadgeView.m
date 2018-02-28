//
//  DCTabBadgeView.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/21.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCTabBadgeView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCTabBadgeView ()



@end

@implementation DCTabBadgeView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpBase];
    }
    return self;
}

#pragma mark - base
- (void)setUpBase
{
    self.userInteractionEnabled = NO;
    self.titleLabel.font = PFR11Font;
    
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backgroundColor = RGB(226, 70, 157);
    
    WEAKSELF
    [[NSNotificationCenter defaultCenter]addObserverForName:@"jump" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"transform.scale";
        animation.values = @[@1.0,@1.1,@0.9,@1.0];
        animation.duration = 0.3;
        animation.calculationMode = kCAAnimationCubic;
        //添加动画
        [weakSelf.layer addAnimation:animation forKey:nil];
    }];
}

#pragma mark - 赋值
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    [self setBadgeViewWithbadgeValue:badgeValue];
}

#pragma mark - 设置
- (void)setBadgeViewWithbadgeValue:(NSString *)badgeValue {
    // 设置文字内容
    [self setTitle:badgeValue forState:UIControlStateNormal];
    // 判断是否有内容,设置隐藏属性
    self.hidden = (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) ? YES : NO;
    NSInteger badgeNumber = [badgeValue integerValue];
    // 如果文字尺寸大于控件宽度
    
    if (badgeNumber > 99) {
        [self setTitle:@"99+" forState:UIControlStateNormal];
    }
    
    self.dc_size = CGSizeMake(22, 22);
    
    [DCSpeedy dc_chageControlCircularWith:self AndSetCornerRadius:11 SetBorderWidth:1 SetBorderColor:DCBGColor canMasksToBounds:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
