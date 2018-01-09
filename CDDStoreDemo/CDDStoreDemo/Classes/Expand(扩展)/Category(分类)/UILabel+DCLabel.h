//
//  UILabel+DCLabel.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DCLabel)


/**
 设置label行间距

 @param text 文本
 @param lineSpacing 行间距
 */
- (void)dc_SetText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;


@end
