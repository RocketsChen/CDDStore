//
//  DCPlaceholderTextView.m
//  JFYInvestment
//
//  Created by apple on 2017/7/16.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCPlaceholderTextView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCPlaceholderTextView ()

/* 占位文字label */
@property (strong , nonatomic)UILabel *placeholderLabel;


@end

@implementation DCPlaceholderTextView

#pragma mark - 懒加载
-(UILabel *)placeholderLabel
{
    if (! _placeholderLabel) {
        //添加一个用来显示占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
        _placeholderLabel.dc_x = 4;
        _placeholderLabel.dc_y = 7;
        
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //竖直方向永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        self.font = [UIFont systemFontOfSize:16];
        
        self.placeholderColor = [UIColor lightGrayColor];
        
        //监听文字改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        //竖直方向永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        self.font = [UIFont systemFontOfSize:16];
        
        self.placeholderColor = [UIColor lightGrayColor];
        
        //监听文字改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}


#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    [self updatePlaceholderLabelSize];
    
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}


#pragma mark - 监听占位文字改变
- (void)textDidChange
{
    //占位文字现在是还是隐藏
    self.placeholderLabel.hidden = self.hasText;
}


/**
 更新占位文字的尺寸
 */
- (void)updatePlaceholderLabelSize
{
    CGSize maxSize = CGSizeMake(ScreenW - 2 * self.placeholderLabel.dc_x, MAXFLOAT);
    self.placeholderLabel.dc_size = [_placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
}

/**
 * 更新占位文字的尺寸
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLabel.dc_width = self.dc_width - 2 * self.placeholderLabel.dc_x;
    [self.placeholderLabel sizeToFit];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
