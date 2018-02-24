//
//  DCComImagesView.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/23.
//Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCComImagesView : UIView

/* 图片 */
@property (nonatomic, copy) NSArray *picUrlArray;
/* 评论 */
@property (strong , nonatomic)NSString *comContent;
/* 规格 */
@property (strong , nonatomic)NSString *comSpecifications;


@end
