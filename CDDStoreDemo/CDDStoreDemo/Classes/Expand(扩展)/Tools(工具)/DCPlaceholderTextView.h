//
//  DCPlaceholderTextView.h
//  JFYInvestment
//
//  Created by apple on 2017/7/16.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCPlaceholderTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;

/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;



@end
