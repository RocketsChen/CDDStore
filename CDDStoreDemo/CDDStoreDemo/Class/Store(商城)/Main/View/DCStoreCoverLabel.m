//
//  DCStoreCoverLabel.m
//  CDDStoreDemo
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreCoverLabel.h"
#import "DCSpeedy.h"

@implementation DCStoreCoverLabel

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpIn];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder])
    {
        [self setUpIn];
    }
    return self;
}

- (void)setUpIn
{
    self.textColor = [UIColor darkGrayColor];
    self.font = [UIFont systemFontOfSize:12];
}



@end
