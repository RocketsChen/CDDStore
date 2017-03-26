//
//  UIButton+Bootstrap.h
//  UIButton+Bootstrap
//
//  Created by Oskar Groth on 2013-09-29.
//  Copyright (c) 2013 Oskar Groth. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NSString+FontAwesome.h"
@interface UIButton (Bootstrap)
//- (void)addAwesomeIcon:(FAIcon)icon beforeTitle:(BOOL)before;
-(void)bootstrapStyle:(CGFloat)cornerRadius;
//-(void)defaultStyleWithNormalTitleColor:(UIColor *)titleColor andHighTitleColor:(UIColor *)highTitleColor andBorderColor:(UIColor *)borderColor andBgColor:(UIColor *)bgColor andHighBgColor:(UIColor *)highBgColor;
-(void)defaultStyleWithNormalTitleColor:(UIColor *)titleColor andHighTitleColor:(UIColor *)highTitleColor andBorderColor:(UIColor *)borderColor andBackgroundColor:(UIColor *)bgColor andHighBgColor:(UIColor *)highBgColor withcornerRadius:(CGFloat)cornerRadius;
//-(void)primaryStyle;
//-(void)successStyle;
//-(void)infoStyle;
//-(void)warningStyle;
//-(void)dangerStyle;

/** 设置按钮的全部属性 */
-(void)defaultStyleWithNormalTitleColor:(UIColor *)titleColor andHighTitleColor:(UIColor *)highTitleColor andBorderColor:(UIColor *)borderColor andBackgroundColor:(UIColor *)bgColor andHighBgColor:(UIColor *)highBgColor andSelectedBgColor:(UIColor *)selectedBgColor withcornerRadius:(CGFloat)cornerRadius;
/** 只设置按钮的 背影颜色 */
-(void)customBtnStyleBackgroundColor:(UIColor *)bgColor andHighBgColor:(UIColor *)highBgColor andSelectedBgColor:(UIColor *)selectedBgColor;

- (void)setImageWithTitle:(UIImage *)image withTitle:(NSString *)title position:(NSString *)_position font:(UIFont *)_font forState:(UIControlState)stateType;

- (void)setFamillyImageWithTitle:(UIImage *)image withTitle:(NSString *)title position:(NSString *)_position font:(UIFont *)_font forState:(UIControlState)stateType;

- (void)setSellerDetailImageWithTitle:(UIImage *)image withTitle:(NSString *)title position:(NSString *)_position font:(UIFont *)_font forState:(UIControlState)stateType;

- (void)setLootProductImageWithTitle:(UIImage *)image withTitle:(NSString *)title position:(NSString *)_position font:(UIFont *)_font forState:(UIControlState)stateType;

- (void)setBtnWithImgStr:(NSString *)imgStr withTittle:(NSString *)tittle;
@end
