//
//  UIImage+DCCircle.m
//  CDDMall
//
//  Created by apple on 2017/6/28.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "UIImage+DCCircle.h"

@implementation UIImage (DCCircle)

- (instancetype)dc_circleImage{
    
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    // 绘制图片
    [self drawInRect:rect];
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)dc_circleImage:(NSString *)name{
    
    return [[self imageNamed:name] dc_circleImage];
}



@end
