//
//  DCCommentsCntCell.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/23.
//Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCCommentsItem;

@interface DCCommentsCntCell : UITableViewCell

/* 评论数据 */
@property (strong , nonatomic)DCCommentsItem *commentsItem;

@end
