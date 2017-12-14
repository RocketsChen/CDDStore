//
//  DCTitleRolling.h
//  CDDTitleRolling
//
//  Created by dashen on 2017/11/17.
//Copyright © 2017年 com.RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

// 每条几组数据
typedef enum : NSUInteger {
    CDDRollingOneGroup , // 默认一种（类似京东、国美）
    CDDRollingTwoGroup, // 两种（类似淘宝）
} CDDRollingGroupStyle;


@protocol CDDRollingDelegate<NSObject>

- (void)dc_RollingViewSelectWithActionAtIndex:(NSInteger)index;

@end


@interface DCTitleRolling : UIView


/** 点击代理 */
@property (nonatomic , assign) id<CDDRollingDelegate>delegate;
/** 更多点击回调 */
@property (nonatomic, copy) dispatch_block_t moreClickBlock;

/* 图片 */
@property (strong , nonatomic)UIImageView *leftImageView;
/* 按钮 */
@property (strong , nonatomic)UIButton *rightButton;

/**
 数据
 
 *leftImage 左边图片
 *rolTitles 标题数组
 *rolTags   tag数组
 *rightImages 右边图片数组
 *rightbuttonTitle 右边按钮（支持点击回调）
 *interval 定时器滚动间隔
 *rollingTime 滚动一次时间的长短
 *titleFont 标题尺寸
 *titleColor 标题颜色
 *isShowTagBorder 是否展示tag标题边框（默认不）
 @param frame 滚动标题的frame
 @param titleDataBlock 设置滚动内部的数据
 @return 数据展示
 */
- (instancetype)initWithFrame:(CGRect)frame WithTitleData:(void(^)(CDDRollingGroupStyle *rollingGroupStyle, NSString **leftImage,NSArray **rolTitles,NSArray **rolTags,NSArray **rightImages,NSString **rightbuttonTitle,NSInteger *interval,float *rollingTime,NSInteger *titleFont,UIColor **titleColor,BOOL *isShowTagBorder))titleDataBlock;

/**
 开始滚动
 */
- (void)dc_beginRolling;

/**
 结束滚动
 */
- (void)dc_endRolling;

@end
