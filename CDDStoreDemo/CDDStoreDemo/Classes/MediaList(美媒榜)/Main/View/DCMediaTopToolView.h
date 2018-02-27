//
//  DCMediaTopToolView.h
//  CDDStoreDemo
//
//  Created by dashen on 2017/12/4.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCMediaTopToolView : UIView

/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
@property (nonatomic, copy) void(^rightItemClickBlock)(UIButton *sender);

/** 搜索按钮点击点击 */
@property (nonatomic, copy) dispatch_block_t searchButtonClickBlock;

@end
