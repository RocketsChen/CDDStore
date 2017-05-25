//
//  DCShopItemView.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCShopItemView.h"

#import "DCConsts.h"

#import "UIView+DCExtension.h"

#define BGColor  Color(245, 58, 64)

#define margin 15
/*** 屏幕的宽 */
#define DCScreenW [UIScreen mainScreen].bounds.size.width
/*** 屏幕的高 */
#define DCScreenH [UIScreen mainScreen].bounds.size.height
/*** RGB */
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@implementation DCShopItemView

+ (DCShopItemView *)attributeViewWithTitle:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)titleColor WithBtnBgColor:(UIColor *)bgColor titleNormalColor:(UIColor *)normalColor titleSelectColor:(UIColor *)selectColor WithButtonCornerRadius:(NSInteger)radius attributeTexts:(NSArray *)texts viewWidth:(CGFloat)viewWidth
{
    int count = 0;
    float btnW = 0;
    DCShopItemView *view = [[DCShopItemView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"%@ : ",title];
    label.font = font;
    label.textColor = titleColor;
    CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName : font}];
    label.frame = (CGRect){{10,10},size};
    [view addSubview:label];
    for (int i = 0; i<texts.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        [btn addTarget:view action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        NSString *str = texts[i];
        [btn setTitle:str forState:UIControlStateNormal];
        CGSize strsize = [str sizeWithAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:12]}];
        btn.dc_width = strsize.width + margin;
        btn.dc_height = strsize.height + margin;
        
        if (i == 0) {
            btn.dc_x = margin;
            btnW += CGRectGetMaxX(btn.frame);
        }
        else{
            btnW += CGRectGetMaxX(btn.frame)+margin;
            if (btnW > viewWidth) {
                count++;
                btn.dc_x = margin;
                btnW = CGRectGetMaxX(btn.frame);
            }
            else{
                
                btn.dc_x += btnW - btn.dc_width;
                
            }
        }
        btn.backgroundColor = bgColor;
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
        [btn setTitleColor:selectColor forState:UIControlStateSelected];
        btn.dc_y += count * (btn.dc_height + margin) + margin + label.dc_height +8;
        
        btn.layer.cornerRadius = btn.dc_height/radius;
        
        btn.clipsToBounds = YES;
        btn.tag = i;
        [view addSubview:btn];
        if (i == texts.count - 1) {
            view.dc_height = CGRectGetMaxY(btn.frame) + DCMargin;
            view.dc_x = 0;
            view.dc_width = viewWidth;
        }
    }
    return view;
}

- (void)btnClick:(UIButton *)sender{
    
    if (![self.btn isEqual:sender]) {
        self.btn.backgroundColor = [UIColor colorWithRed:(229)/255.0 green:(229)/255.0 blue:(229)/255.0 alpha:1.0];
        self.btn.selected = NO;
        sender.backgroundColor = [UIColor redColor];
        sender.selected = YES;
        //按钮传递
        if ([self.ShopItem_delegate respondsToSelector:@selector(ShopItem_View:didClickBtn:)] ) {
            [self.ShopItem_delegate ShopItem_View:self didClickBtn:sender];
        }
    }else{
        
    }
    
    self.btn = sender;
}


@end
