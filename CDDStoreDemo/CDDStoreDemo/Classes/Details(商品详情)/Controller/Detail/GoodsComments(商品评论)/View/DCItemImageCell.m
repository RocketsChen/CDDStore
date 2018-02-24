//
//  DCItemImageCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/24.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "DCItemImageCell.h"

@implementation DCItemImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _itemImageView = [UIImageView new];
        _itemImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_itemImageView];
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _itemImageView.frame = self.bounds;
}


@end
