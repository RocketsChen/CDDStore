//
//  UIButton+Bootstrap.m
//  UIButton+Bootstrap
//
//  Created by Oskur on 2013-09-29.
//  Copyright (c) 2013 Oskar Groth. All rights reserved.
//
#import "UIButton+Bootstrap.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
@implementation UIButton (Bootstrap)

-(void)bootstrapStyle:(CGFloat)cornerRadius{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)defaultStyleWithNormalTitleColor:(UIColor *)titleColor andHighTitleColor:(UIColor *)highTitleColor andBorderColor:(UIColor *)borderColor andBackgroundColor:(UIColor *)bgColor andHighBgColor:(UIColor *)highBgColor withcornerRadius:(CGFloat)cornerRadius{
    [self bootstrapStyle:cornerRadius];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:highTitleColor forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self buttonImageFromColor:bgColor] forState:UIControlStateNormal];
    self.layer.borderColor = [borderColor CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:highBgColor] forState:UIControlStateHighlighted];
}

-(void)defaultStyleWithNormalTitleColor:(UIColor *)titleColor andHighTitleColor:(UIColor *)highTitleColor andBorderColor:(UIColor *)borderColor andBackgroundColor:(UIColor *)bgColor andHighBgColor:(UIColor *)highBgColor andSelectedBgColor:(UIColor *)selectedBgColor withcornerRadius:(CGFloat)cornerRadius{
    [self bootstrapStyle:cornerRadius];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:highTitleColor forState:UIControlStateHighlighted];
    [self setTitleColor:highTitleColor forState:UIControlStateSelected];
    self.layer.borderColor = [borderColor CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:bgColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:highBgColor] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self buttonImageFromColor:selectedBgColor] forState:UIControlStateSelected];
}
-(void)customBtnStyleBackgroundColor:(UIColor *)bgColor andHighBgColor:(UIColor *)highBgColor andSelectedBgColor:(UIColor *)selectedBgColor {
    [self setBackgroundImage:[self buttonImageFromColor:bgColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:highBgColor] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self buttonImageFromColor:selectedBgColor] forState:UIControlStateSelected];
}
- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
/**
 *  自定义按钮 图片和文字的样式
 *
 *  @param image     图片
 *  @param title     按钮文字
 *  @param _position 图片的位置
 *  @param _font     尺寸
 *  @param stateType 按钮的状态
 */
- (void)setImageWithTitle:(UIImage *)image withTitle:(NSString *)title position:(NSString *)_position font:(UIFont *)_font forState:(UIControlState)stateType{
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = _font;
    CGSize titleSize = [title sizeWithAttributes:attr];
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    if([_position isEqualToString:@"left"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2, 10.0, 0.0, 0)];
    }else if([_position isEqualToString:@"top"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake(2.0, 0.0, 25.0, -titleSize.width)];
    }else if([_position isEqualToString:@"right"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2, titleSize.width + 25, 0.0, 0.0)];
    }
    
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:_font];
    
    if([_position isEqualToString:@"left"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2,
                                                  image.size.width,
                                                  0.0,
                                                  0.0)];
    }else if([_position isEqualToString:@"top"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake(50.0,
                                                  -image.size.width,
                                                  0.0,
                                                  0.0)];
    }else if([_position isEqualToString:@"right"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2,
                                                  -40.0,
                                                  0.0,
                                                  0)];
    }
    
    
    [self setTitle:title forState:stateType];
}

- (void)setFamillyImageWithTitle:(UIImage *)image withTitle:(NSString *)title position:(NSString *)_position font:(UIFont *)_font forState:(UIControlState)stateType
{
    //    CGSize titleSize = [title sizeWithFont:_font];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = _font;
    CGSize titleSize = [title sizeWithAttributes:attr];
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    if([_position isEqualToString:@"left"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2, 10.0, 0.0, 0)];
    }else if([_position isEqualToString:@"top"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 15.0, -titleSize.width)];
    }else if([_position isEqualToString:@"right"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2, titleSize.width + 25, 0.0, 0.0)];
    }
    
    
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:_font];
    
    if([_position isEqualToString:@"left"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2,
                                                  image.size.width,
                                                  0.0,
                                                  0.0)];
    }else if([_position isEqualToString:@"top"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake(25.0,
                                                  -image.size.width,
                                                  0.0,
                                                  0.0)];
    }else if([_position isEqualToString:@"right"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2,
                                                  -40.0,
                                                  0.0,
                                                  0)];
    }
    
    
    [self setTitle:title forState:stateType];
}

- (void)setSellerDetailImageWithTitle:(UIImage *)image withTitle:(NSString *)title position:(NSString *)_position font:(UIFont *)_font forState:(UIControlState)stateType
{
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = _font;
    CGSize titleSize = [title sizeWithAttributes:attr];
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    if([_position isEqualToString:@"left"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2, 10.0, 0.0, 0)];
    }else if([_position isEqualToString:@"top"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake(2.0, 0.0, 25.0, -titleSize.width)];
    }else if([_position isEqualToString:@"right"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2, titleSize.width + 25, 0.0, 0.0)];
    }
    
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:_font];
    
    if([_position isEqualToString:@"left"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2,
                                                  image.size.width,
                                                  0.0,
                                                  0.0)];
    }else if([_position isEqualToString:@"top"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake(40.0,
                                                  -image.size.width,
                                                  0.0,
                                                  0.0)];
    }else if([_position isEqualToString:@"right"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2,
                                                  -40.0,
                                                  0.0,
                                                  0)];
    }
    
    
    [self setTitle:title forState:stateType];
}

- (void)setLootProductImageWithTitle:(UIImage *)image withTitle:(NSString *)title position:(NSString *)_position font:(UIFont *)_font forState:(UIControlState)stateType
{
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = _font;
    CGSize titleSize = [title sizeWithAttributes:attr];
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    if([_position isEqualToString:@"left"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2, 10.0, 0.0, 0)];
    }else if([_position isEqualToString:@"top"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake(5.0, 5.0, 18.0, -titleSize.width + 5)];
//        [self setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
    }else if([_position isEqualToString:@"right"]){
        [self setImageEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2, titleSize.width + 25, 0.0, 0.0)];
    }
    
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:_font];
    
    if([_position isEqualToString:@"left"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2,
                                                  image.size.width,
                                                  0.0,
                                                  0.0)];
    }else if([_position isEqualToString:@"top"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake(32.0,
                                                  -image.size.width,
                                                  0.0,
                                                  0.0)];
    }else if([_position isEqualToString:@"right"]){
        [self setTitleEdgeInsets:UIEdgeInsetsMake((self.frame.size.height - 50)/2,
                                                  -40.0,
                                                  0.0,
                                                  0)];
    }
    
    
    [self setTitle:title forState:stateType];
}

- (void)setBtnWithImgStr:(NSString *)imgStr withTittle:(NSString *)tittle {
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:nil options:SDWebImageProgressiveDownload];
    CGFloat imgViewWH = self.frame.size.width - 40;
    imgView.frame = (CGRect){20, 10, imgViewWH, imgViewWH};
    imgView.layer.cornerRadius = imgViewWH/2;
    [self addSubview:imgView];
    
    UILabel *tittleLbl = [[UILabel alloc] init];
    tittleLbl.text = tittle;
    tittleLbl.textAlignment = NSTextAlignmentCenter;
    tittleLbl.font = [UIFont systemFontOfSize:13];
    tittleLbl.frame = (CGRect){0, CGRectGetMaxY(imgView.frame) + 5, self.frame.size.width, 15};
    [self addSubview:tittleLbl];
}
@end
