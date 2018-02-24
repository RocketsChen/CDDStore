//
//  DCCommentsItem.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/23.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//
/** 回复帖子宽高 */
#define MiddleImageH  (CGRectGetWidth([UIScreen mainScreen].bounds) - 40)/5
#define MiddleImageW  MiddleImageH



#import "DCCommentsItem.h"

@implementation DCCommentsItem

- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    
    CGFloat top = 50;
    CGFloat bottom = 58;
    
    CGFloat contentH = [DCSpeedy dc_calculateTextSizeWithText:_comContent WithTextFont:14 WithMaxW:ScreenW - 20].height;
    
    CGFloat middle = contentH;
    
    //店家回复
    CGFloat comBackH = [DCSpeedy dc_calculateTextSizeWithText:_comReBack WithTextFont:13 WithMaxW:ScreenW - 40].height + DCMargin;
    CGFloat imagesH = 0;
    
    //图片数组
    if (self.imgsArray.count) {
        if (self.imgsArray.count > 5) return 0;
        CGFloat contentH = MiddleImageH; //图片高度 + 间隙
        //中间内容的Frame
        CGRect middleF = CGRectMake(DCMargin, top , ScreenW - 20, contentH);
        self.imagesFrames = middleF;
        
        imagesH = contentH + DCMargin * 0.8;
    }
    
    if (_comReBack.length != 0 && !_imgsArray) { //只有店家回复，没有图片
        
        middle +=  comBackH;
    
    }else if (_imgsArray && _comReBack.length == 0){ //有图片，没有店家回复
        
        middle += imagesH;
        
    }else if (_imgsArray && _comReBack.length != 0){  //两者都有
        
        middle += imagesH;
        middle += comBackH;
        
    }
    
    _cellHeight = top + bottom + middle;
    return _cellHeight;
}

@end
