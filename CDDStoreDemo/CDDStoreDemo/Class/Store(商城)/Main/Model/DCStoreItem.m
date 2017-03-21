//
//  DCStoreItem.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreItem.h"
#import "DCConsts.h"

@implementation DCStoreItem

- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    CGSize titleSize = [self calculateTextSizeWithText:_goods_title WithTextFont:14 WithMaxW:ScreenW - 103];
    CGSize secondttSize = [self calculateTextSizeWithText:_secondtitle WithTextFont:12 WithMaxW:ScreenW - 103];
    _cellHeight = 62 + titleSize.height + secondttSize.height;
    
    return _cellHeight;
}


#pragma mark -  根据传入字体大小计算字体宽高
- (CGSize)calculateTextSizeWithText : (NSString *)text WithTextFont: (NSInteger)textFont WithMaxW : (CGFloat)maxW {
    
    CGFloat textMaxW = maxW;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont]} context:nil].size;
    
    return textSize;
}

@end
