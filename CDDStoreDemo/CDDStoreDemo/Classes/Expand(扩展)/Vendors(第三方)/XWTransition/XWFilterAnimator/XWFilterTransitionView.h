//
//  XWBlurView.h
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWFilterTransitionView : GLKView

@property (nonatomic, assign) BOOL blurType;
@property (nonatomic, strong) CIFilter *filter;

- (instancetype)initWithFrame:(CGRect)frame
                    fromImage:(UIImage *)fromImage
                      toImage:(UIImage *)toImage;

- (CAAnimation *)xw_getInnerAnimation;

- (CIVector *)xw_getInnerVector;

+ (void)xw_animationWith:(XWFilterTransitionView *)filterView duration:(NSTimeInterval)duration completion:(void (^ __nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END