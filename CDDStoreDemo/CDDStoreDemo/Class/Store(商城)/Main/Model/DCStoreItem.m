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


- (CGFloat)isCellHeight
{
    if (_isCellHeight) return _isCellHeight;
    
    CGSize titleSize = [self calculateTextSizeWithText:_goods_title WithTextFont:14 WithMaxW:ScreenW - 4 - 20 - 77];
    CGSize secondSize = [self calculateTextSizeWithText:_secondtitle WithTextFont:12 WithMaxW:ScreenW - 4 - 20 - 77];
    CGSize saleSize = [self calculateTextSizeWithText:_sale_count WithTextFont:12 WithMaxW:ScreenW - 4 - 20 - 77];
    CGSize priceSize = [self calculateTextSizeWithText:_price WithTextFont:16 WithMaxW:ScreenW - 4 - 20 - 77];
    CGFloat margin = 32;
    
    _isCellHeight = titleSize.height + secondSize.height + saleSize.height + priceSize.height + margin;
    
    return _isCellHeight;
}

-(CGFloat)isGardHeight
{
    if (_isCellHeight) return _isCellHeight;
    
    CGFloat imageH = (ScreenW - 6) / 2 - 20;
    
    CGSize titleSize = [self calculateTextSizeWithText:_goods_title WithTextFont:14 WithMaxW:(ScreenW - 6) / 2 - 20];
    CGSize secondtSize = [self calculateTextSizeWithText:_secondtitle WithTextFont:12 WithMaxW:(ScreenW - 6) / 2 - 20];
    CGSize saleSize = [self calculateTextSizeWithText:_sale_count WithTextFont:12 WithMaxW:(ScreenW - 6) / 2 - 20];
    CGSize priceSize = [self calculateTextSizeWithText:_price WithTextFont:16 WithMaxW:(ScreenW - 6) / 2 - 20];
    CGFloat margin = 42;
    
    _isCellHeight = imageH + titleSize.height + secondtSize.height + saleSize.height + priceSize.height + margin;
    
    return _isCellHeight;
}

#pragma mark -  根据传入字体大小计算字体宽高
- (CGSize)calculateTextSizeWithText : (NSString *)text WithTextFont: (NSInteger)textFont WithMaxW : (CGFloat)maxW {
    
    CGFloat textMaxW = maxW;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont]} context:nil].size;
    
    return textSize;
}

@end
