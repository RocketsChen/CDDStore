//
//  UILabel+DCLabel.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "UILabel+DCLabel.h"

@implementation UILabel (DCLabel)

#pragma mark - 设置label行间距
- (void)dc_SetText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    
    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    self.attributedText = attributedString;
}




@end
