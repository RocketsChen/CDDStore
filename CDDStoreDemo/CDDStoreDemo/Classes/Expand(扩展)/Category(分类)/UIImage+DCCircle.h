//
//  UIImage+DCCircle.h
//  CDDMall
//
//  Created by apple on 2017/6/28.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DCCircle)

/**
 *  返回圆形图片
 */
- (instancetype)dc_circleImage;

+ (instancetype)dc_circleImage:(NSString *)name;

@end
