//
//  DCCameraTopView.h
//  STOExpressDelivery
//
//  Created by 陈甸甸 on 2017/12/26.
//Copyright © 2017年 STO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCameraTopView : UIView

/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;
/** 右边第二个Item点击 */
@property (nonatomic, copy) dispatch_block_t rightRItemClickBlock;


@end
