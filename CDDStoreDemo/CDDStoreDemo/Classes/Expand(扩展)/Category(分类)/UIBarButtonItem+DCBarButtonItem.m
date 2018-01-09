//
//  UIBarButtonItem+DCBarButtonItem.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIBarButtonItem+DCBarButtonItem.h"

@implementation UIBarButtonItem (DCBarButtonItem)

+ (UIBarButtonItem *)ItemWithImage:(UIImage *)image WithHighlighted:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:HighlightedImage forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)ItemWithImage:(UIImage *)image WithSelected:(UIImage *)SelectedImage Target:(id)target action:(SEL)action
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:SelectedImage forState:UIControlStateSelected];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image WithHighlightedImage:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action title:(NSString *)title
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:HighlightedImage forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}



@end
