//
//  DCContentItem.h
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface DCContentItem : NSObject


@property (nonatomic , strong) NSString *content;
/** 是否点击 */
@property (nonatomic,assign)BOOL isSelect;

@end
