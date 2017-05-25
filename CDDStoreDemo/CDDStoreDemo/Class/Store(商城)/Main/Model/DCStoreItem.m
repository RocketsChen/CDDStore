//
//  DCStoreItem.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreItem.h"
#import "DCConsts.h"

#import "DCSpeedy.h"

@implementation DCStoreItem

#pragma mark - 普通cell
- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    CGSize titleSize = [DCSpeedy calculateTextSizeWithText:_goods_title WithTextFont:14 WithMaxW:ScreenW - 103];
    CGSize secondttSize = [DCSpeedy calculateTextSizeWithText:_secondtitle WithTextFont:12 WithMaxW:ScreenW - 103];
    _cellHeight = 62 + titleSize.height + secondttSize.height;
    
    return _cellHeight;
}

#pragma mark - 列表cell
- (CGFloat)isCellHeight
{
    if (_isCellHeight) return _isCellHeight;
    
    CGSize titleSize = [DCSpeedy calculateTextSizeWithText:_goods_title WithTextFont:14 WithMaxW:ScreenW - 30 - 77];
    CGSize secondSize = [DCSpeedy calculateTextSizeWithText:_secondtitle WithTextFont:12 WithMaxW:ScreenW - 30 - 77];
    CGSize saleSize = [DCSpeedy calculateTextSizeWithText:_sale_count WithTextFont:12 WithMaxW:ScreenW - 30 - 77];
    CGSize priceSize = [DCSpeedy calculateTextSizeWithText:_price WithTextFont:16 WithMaxW:ScreenW - 30 - 77];
    CGFloat margin = 22;
    
    _isCellHeight = titleSize.height + secondSize.height + saleSize.height + priceSize.height + margin;
    
    _cellHeight = (_isCellHeight < 77) ? 87:_isCellHeight;
    return _isCellHeight;
}

#pragma mark - 视图cell
-(CGFloat)isGardHeight
{
    if (_isGardHeight) return _isGardHeight;
    
    CGFloat imageH = (ScreenW - DCMargin) / 2.f;
    
    CGSize titleSize = [DCSpeedy calculateTextSizeWithText:_goods_title WithTextFont:14 WithMaxW:(ScreenW - DCMargin) / 2.f - 10];
    CGSize secondtSize = [DCSpeedy calculateTextSizeWithText:_secondtitle WithTextFont:12 WithMaxW:(ScreenW - DCMargin) / 2.f - 10];
    CGSize saleSize = [DCSpeedy calculateTextSizeWithText:_sale_count WithTextFont:12 WithMaxW:(ScreenW - DCMargin) / 2.f - 10];
    CGSize priceSize = [DCSpeedy calculateTextSizeWithText:_price WithTextFont:16 WithMaxW:(ScreenW - DCMargin) / 2.f - 10];
    CGFloat margin = 32;
    
    _isGardHeight = imageH + titleSize.height + secondtSize.height + saleSize.height + priceSize.height + margin;
    
    return _isGardHeight;
}


@end
