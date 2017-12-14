//
//  DCPageControl.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/9.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCPageControl.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCPageControl ()



@end

@implementation DCPageControl

#pragma mark - Intial
#pragma mark - 重写setCurrentPage方法更改PageControl的大小和图片
- (void)setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView *subView = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 6;
        size.width = 6;
        [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y,size.width,size.height)];
    }
}


@end
