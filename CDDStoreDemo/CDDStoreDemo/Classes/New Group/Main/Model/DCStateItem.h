//
//  DCStateItem.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCStateItem : NSObject

/* 显示文字图片 */
@property (nonatomic, assign) BOOL showImage;

/* 图片或数字 */
@property (nonatomic, copy) NSString *imageContent;

/* 标题 */
@property (nonatomic, copy) NSString *stateTitle;

/* 背景色 */
@property (nonatomic, assign) BOOL bgColor;

@end
