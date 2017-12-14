//
//  DCCommentPicItem.h
//  CDDMall
//
//  Created by apple on 2017/6/29.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCCommentPicItem : NSObject

/* 用户名 */
@property (copy , nonatomic)NSString *nickName;

/* 图片 */
@property (strong , nonatomic)NSArray *images;

@end
