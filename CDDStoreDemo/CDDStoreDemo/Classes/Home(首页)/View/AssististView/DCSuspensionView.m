

//
//  DCSuspensionView.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/11/28.
//Copyright © 2017年 RocketsChen. All rights reserved.
//
#define DCSuspensionViewDisNotificationName    @"SUSPENSIONVIEWDISAPPER_NOTIFICATIONNAME"
#define DCSuspensionViewShowNotificationName  @"SUSPENSIONVIEWSHOW_NOTIFICATIONNAME"
#define DCProportion           0.82
#define DCDismisTime           0.25

#import "DCSuspensionView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCSuspensionView ()



@end

@implementation DCSuspensionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}
- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
            
            [self commitTranslation:[pan translationInView:self]];
            
            [pan setTranslation:CGPointZero inView:self];
            
            break;
        case UIGestureRecognizerStateEnded:
            
            if (CGRectGetMaxX(pan.view.frame) < (ScreenW * DCProportion)/2) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:DCSuspensionViewDisNotificationName object:nil];
                
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:DCSuspensionViewShowNotificationName object:nil];
            }
            
            break;
            
        default:
            break;
    }
    
}

- (void)commitTranslation:(CGPoint)translation
{
    
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y);
    
    if (absX > absY) {
        
        if (translation.x < 0) {
            
            self.dc_x += translation.x;
            
        }else{
            
            [UIView animateWithDuration:DCDismisTime animations:^{
                
                self.dc_x = 0;
            }];
        }
        
    }
}


#pragma mark - Setter Getter Methods

@end
