//
//  DCBeautyHotItem.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCBeautyHotItem : NSObject

/* 主标题 */
@property (nonatomic, copy) NSString *beautyTitle;
/* 第二标题 */
@property (nonatomic, copy) NSString *secondTitle;
/* 观看人数 */
@property (nonatomic, copy) NSString *watchNum;
/* 图片数组 */
@property (nonatomic, copy) NSArray *groupImage;

@end
