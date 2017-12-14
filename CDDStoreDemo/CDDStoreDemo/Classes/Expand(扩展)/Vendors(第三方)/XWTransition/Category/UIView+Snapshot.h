//
//  UIView+Snapshot.h
//  XWTransitionDemo
//
//  Created by 肖文 on 2016/12/16.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Snapshot)

@property (nonatomic, readonly) UIImage *snapshotImage;
@property (nonatomic, strong) UIImage *contentImage;


@end
