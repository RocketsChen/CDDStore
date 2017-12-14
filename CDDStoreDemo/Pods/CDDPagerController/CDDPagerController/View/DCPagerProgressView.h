//
//  DCPagerProgressView.h
//  CDDPagerController
//
//  Created by apple on 2017/9/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface DCPagerProgressView : UIView

/** 进度条 */
@property (nonatomic, assign) CGFloat progress;
/** 尺寸 */
@property (nonatomic, strong) NSMutableArray *itemFrames;
/** 颜色 */
@property (nonatomic, assign) CGColorRef color;

/** 是否拉伸 */
@property (nonatomic, assign) BOOL isStretch;

@end
