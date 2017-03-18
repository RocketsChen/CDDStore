//
//  UIView+TXFrame.m
//  TXSwipeTableViewTest
//
//  Created by tingxins on 9/1/16.
//  Copyright © 2016 tingxins. All rights reserved.
//

#import "UIView+TXFrame.h"

@implementation UIView (TXFrame)

- (CGFloat)tx_x {
    return self.frame.origin.x;
}

- (void)setTx_x:(CGFloat)tx_x {
    CGRect frame = self.frame;
    frame.origin.x = tx_x;
    self.frame = frame;
}

- (CGFloat)tx_y {
    return self.frame.origin.y;
}

- (void)setTx_y:(CGFloat)tx_y {
    CGRect frame = self.frame;
    frame.origin.y = tx_y;
    self.frame = frame;
}

- (CGFloat)tx_width {
    return self.frame.size.width;
}

- (void)setTx_width:(CGFloat)tx_width {
    CGRect frame = self.frame;
    frame.size.width = tx_width;
    self.frame = frame;
}

- (CGFloat)tx_height {
    return self.frame.size.height;
}

- (void)setTx_height:(CGFloat)tx_height {
    CGRect frame = self.frame;
    frame.size.height = tx_height;
    self.frame = frame;
}

- (CGSize)tx_size {
    return self.frame.size;
}

- (void)setTx_size:(CGSize)tx_size {
    CGRect frame = self.frame;
    frame.size = tx_size;
    self.frame = frame;
}

- (CGPoint)tx_origin {
    return self.frame.origin;
}

- (void)setTx_origin:(CGPoint)tx_origin {
    CGRect frame = self.frame;
    frame.origin = tx_origin;
    self.frame = frame;
}

- (CGPoint)tx_center {
    return self.center;
}

- (void)setTx_center:(CGPoint)tx_center {
    self.center = tx_center;
}

- (CGFloat)tx_centerX {
    return self.center.x;
}

- (void)setTx_centerX:(CGFloat)tx_centerX {
    CGPoint center = self.center;
    center.x = tx_centerX;
    self.center = center;
}

- (CGFloat)tx_centerY {
    return self.center.y;
}

- (void)setTx_centerY:(CGFloat)tx_centerY {
    CGPoint center = self.center;
    center.y = tx_centerY;
    self.center = center;
}

- (CGFloat)tx_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setTx_bottom:(CGFloat)tx_bottom {
    CGRect frame = self.frame;
    frame.origin.y = tx_bottom - frame.size.height;
    self.frame = frame;
}

@end
