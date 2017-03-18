//
//  UIBarButtonItem+DCBarButtonItem.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DCBarButtonItem)

+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithHighlighted:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action;


+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithSelected:(UIImage *)SelectedImage Target:(id)target action:(SEL)action;



/**
 返回
 */
+(UIBarButtonItem *)backItemWithImage:(UIImage *)image WithHighlightedImage:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action title:(NSString *)title;

@end
