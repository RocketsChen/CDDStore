//
//  UIView+YKCExtension.m
//  YKC好了吗客户端
//
//  Created by Insect on 2017/1/5.
//  Copyright © 2017年 Insect. All rights reserved.
//

#import "UIView+YKCExtension.h"

@implementation UIView (YKCExtension)

-(CGFloat)ykc_x{
    
    return self.frame.origin.x;
}

-(void)setYkc_x:(CGFloat)ykc_x{
    
    CGRect ykcFrame = self.frame;
    ykcFrame.origin.x = ykc_x;
    self.frame = ykcFrame;
}

-(CGFloat)ykc_y{
    
    return self.frame.origin.y;
}

-(void)setYkc_y:(CGFloat)ykc_y{
    
    CGRect ykcFrame = self.frame;
    ykcFrame.origin.y = ykc_y;
    self.frame = ykcFrame;
}

-(CGPoint)ykc_origin{
    
    return self.frame.origin;
}

-(void)setYkc_origin:(CGPoint)ykc_origin{
    
    CGRect ykcPoint = self.frame;
    ykcPoint.origin = ykc_origin;
    self.frame = ykcPoint;
}

-(CGFloat)ykc_width{
    
    return self.frame.size.width;
}

-(void)setYkc_width:(CGFloat)ykc_width{
    
    CGRect ykcFrame = self.frame;
    ykcFrame.size.width = ykc_width;
    self.frame = ykcFrame;
}

-(CGFloat)ykc_height{
    
    return self.frame.size.height;
}

-(void)setYkc_height:(CGFloat)ykc_height{
    
    CGRect ykcFrame = self.frame;
    ykcFrame.size.height = ykc_height;
    self.frame = ykcFrame;
}

-(CGSize)ykc_size{
    
    return self.frame.size;
}

-(void)setYkc_size:(CGSize)ykc_size{
    
    CGRect ykcFrame = self.frame;
    ykcFrame.size = ykc_size;
    self.frame = ykcFrame;
}

-(CGFloat)ykc_centerX{
    
    return self.center.x;
}

-(void)setYkc_centerX:(CGFloat)ykc_centerX{
    
    CGPoint ykcPoint = self.center;
    ykcPoint.x = ykc_centerX;
    self.center = ykcPoint;
}

-(CGFloat)ykc_centerY{
    
    return self.center.y;
}

-(void)setYkc_centerY:(CGFloat)ykc_centerY{
    
    CGPoint ykcPoint = self.center;
    ykcPoint.y = ykc_centerY;
    self.center = ykcPoint;
}

- (CGFloat)ykc_right{
    
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)ykc_bottom{
    
    return CGRectGetMaxY(self.frame);
}

- (void)setYkc_right:(CGFloat)ykc_right{
    
    self.ykc_x = ykc_right - self.ykc_width;
}

- (void)setYkc_bottom:(CGFloat)ykc_bottom{
    
    self.ykc_y = ykc_bottom - self.ykc_height;
}

- (BOOL)intersectWithView:(UIView *)view{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (BOOL)isShowingOnKeyWindow {
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+(instancetype)ykc_viewFromXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}


@end
