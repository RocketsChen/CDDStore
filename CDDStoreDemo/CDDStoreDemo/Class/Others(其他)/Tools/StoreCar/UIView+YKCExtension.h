//
//  UIView+YKCExtension.h
//  YKC好了吗客户端
//
//  Created by Insect on 2017/1/5.
//  Copyright © 2017年 Insect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YKCExtension)

@property (nonatomic , assign) CGFloat ykc_width;
@property (nonatomic , assign) CGFloat ykc_height;
@property (nonatomic , assign) CGSize  ykc_size;
@property (nonatomic , assign) CGFloat ykc_x;
@property (nonatomic , assign) CGFloat ykc_y;
@property (nonatomic , assign) CGPoint ykc_origin;
@property (nonatomic , assign) CGFloat ykc_centerX;
@property (nonatomic , assign) CGFloat ykc_centerY;
@property (nonatomic , assign) CGFloat ykc_right;
@property (nonatomic , assign) CGFloat ykc_bottom;

- (BOOL)intersectWithView:(UIView *)view;

+ (instancetype)ykc_viewFromXib;
- (BOOL)isShowingOnKeyWindow;

@end
