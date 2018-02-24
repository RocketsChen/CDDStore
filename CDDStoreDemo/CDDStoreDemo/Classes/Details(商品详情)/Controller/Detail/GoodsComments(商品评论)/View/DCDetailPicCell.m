//
//  DCDetailPicCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/24.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "DCDetailPicCell.h"

@implementation DCDetailPicCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _itemImageView = [UIImageView new];
        _itemImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_itemImageView];
        _itemImageView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(itemImageViewLongPress:)];
        
        longPressGesture.minimumPressDuration = 1.0;
        [_itemImageView addGestureRecognizer:longPressGesture];
    }
    return self;
}

- (void)itemImageViewLongPress:(UILongPressGestureRecognizer *)longRecognizer
{
    if (longRecognizer.state == UIGestureRecognizerStateBegan){
        !_savePhotoBlock ? : _savePhotoBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _itemImageView.frame = self.bounds;
}

@end
