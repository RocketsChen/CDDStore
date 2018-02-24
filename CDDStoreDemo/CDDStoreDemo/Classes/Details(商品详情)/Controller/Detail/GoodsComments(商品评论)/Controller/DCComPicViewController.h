//
//  DCComPicViewController.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/24.
//Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCComPicViewController : UIViewController


/**
 评论详情页基础设置
 @param BaseSettingBlock 基础设置
 */
- (void)setUpComPicAttribute:(void(^)(NSArray **imageArray,NSString **comComtent,NSString **comSpecifications,NSInteger *selectCount))BaseSettingBlock;


@end
