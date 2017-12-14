
//
//  DCAssistiveTouch.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/11/28.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#define DCWindow          [[UIApplication sharedApplication].windows firstObject]
#define DCAlpha                0.5
#define DCDismisTime           0.25
#define DCProportion           0.82
#define DCSuspensionViewDisNotificationName    @"SUSPENSIONVIEWDISAPPER_NOTIFICATIONNAME"
#define DCSuspensionViewShowNotificationName  @"SUSPENSIONVIEWSHOW_NOTIFICATIONNAME"

#import "DCAssistiveTouch.h"

// Controllers

// Models

// Views
#import "DCSuspensionView.h"
// Vendors

// Categories

// Others

@interface DCAssistiveTouch ()

@property(nonatomic,strong)UIView *bgView;
/* 按钮 */
@property (strong , nonatomic)UIButton *assTouchButtton;
/* 悬浮View */
@property (strong , nonatomic)DCSuspensionView *suspensionView;

@end

static CGFloat _allowance = 30;

@implementation DCAssistiveTouch

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpWindow];
        
        [self setUpButtonWithFrame:frame];
    }
    return self;
}

#pragma mark - 初始化

- (void)setUpWindow {
    
    self.backgroundColor = [UIColor clearColor];
    self.windowLevel = UIWindowLevelAlert + 1;
    [self makeKeyAndVisible];
}

- (void)setUpButtonWithFrame:(CGRect)frame
{
    _assTouchButtton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_assTouchButtton setBackgroundImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    [_assTouchButtton setBackgroundImage:[UIImage imageNamed:@"icon"] forState:UIControlStateDisabled];
    [_assTouchButtton setBackgroundImage:[UIImage imageNamed:@"icon"] forState:UIControlStateHighlighted];
    _assTouchButtton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [_assTouchButtton addTarget:self action:@selector(assTouchButttonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_assTouchButtton];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
    [_assTouchButtton addGestureRecognizer:pan];
    
    self.alpha = 1;
    [self performSelector:@selector(setAlpha) withObject:nil afterDelay:5];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disapper:) name:DCSuspensionViewDisNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(assTouchButttonTouch) name:DCSuspensionViewShowNotificationName object:nil];
}


- (void)assTouchButttonTouch
{
    [DCWindow addSubview:self.bgView];
    [DCWindow addSubview:self.suspensionView];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}


-(void)changePostion:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect originalFrame = self.frame;
    if (originalFrame.origin.x >= 0 && originalFrame.origin.x+originalFrame.size.width <= width) {
        originalFrame.origin.x += point.x;
    }
    if (originalFrame.origin.y >= 0 && originalFrame.origin.y+originalFrame.size.height <= height) {
        originalFrame.origin.y += point.y;
    }
    self.frame = originalFrame;
    [pan setTranslation:CGPointZero inView:self];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self beginPoint];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self changePoint];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self endPoint];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            [self endPoint];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)beginPoint {
    
    _assTouchButtton.enabled = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [UIView animateWithDuration:DCDismisTime animations:^{
        self.alpha = 1.0;
    }];
}



- (void)changePoint {
    
    BOOL isOver = NO;
    
    CGRect frame = self.frame;
    
    if (frame.origin.x < 0) {
        frame.origin.x = 0;
        isOver = YES;
    } else if (frame.origin.x+frame.size.width > DCWindow.dc_width) {
        frame.origin.x = DCWindow.dc_width - frame.size.width;
        isOver = YES;
    }
    
    if (frame.origin.y < 0) {
        frame.origin.y = 0;
        isOver = YES;
    } else if (frame.origin.y+frame.size.height > DCWindow.dc_height) {
        frame.origin.y = DCWindow.dc_height - frame.size.height;
        isOver = YES;
    }
    if (isOver) {
        [UIView animateWithDuration:DCDismisTime animations:^{
            self.frame = frame;
        }];
    }
    _assTouchButtton.enabled = YES;
    
}


- (void)endPoint {
    
    if (self.dc_x <= DCWindow.dc_width / 2 - self.dc_width / 2) {
        
        if (self.dc_y >= DCWindow.dc_height - self.dc_height - _allowance) {
            self.dc_y = DCWindow.dc_height - self.dc_height;
        }else
        {
            if (self.dc_y <= _allowance) {
                self.dc_y = 0;
            }else
            {
                self.dc_x = 0;
            }
        }
        
    }else
    {
        if (self.dc_y >= DCWindow.dc_height - self.dc_height - _allowance) {
            self.dc_y = DCWindow.dc_height - self.dc_height;
        }else
        {
            if (self.dc_y <= _allowance) {
                self.dc_y = 0;
                
            }else{
                self.dc_x = DCWindow.dc_width - self.dc_width;
            }
        }
    }
    
    _assTouchButtton.enabled = YES;
    [self performSelector:@selector(setAlpha) withObject:nil afterDelay:3];
}


- (void)setAlpha {
    
    [UIView animateWithDuration:DCDismisTime animations:^{
        self.alpha = DCAlpha;
    }];
}

- (UIView *)bgView
{
    if (!_bgView) {
        
        _bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper:)];
        _bgView.userInteractionEnabled = YES;
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

-(void)disapper:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:DCDismisTime animations:^{
        
        self.suspensionView.dc_x = -ScreenW * DCProportion;
        self.alpha = 1;
        [self performSelector:@selector(setAlpha) withObject:nil afterDelay:3];
        self.bgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        self.suspensionView.dc_x = -ScreenW * DCProportion;
        self.bgView.alpha = 0;
        
        [self.suspensionView removeFromSuperview];
        [self.bgView removeFromSuperview];
    }];
}

@end
