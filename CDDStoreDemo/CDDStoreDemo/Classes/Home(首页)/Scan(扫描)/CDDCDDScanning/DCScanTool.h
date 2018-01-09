//
//  DCScanTool.h
//  CDDScanningCode
//
//  Created by 陈甸甸 on 2018/1/3.
//  Copyright © 2018年 陈甸甸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCScanTool : NSObject

/**
 调整图片尺寸

 @param UIImage 获取的图片
 @return 调整好的尺寸
 */
#pragma mark - 调整图片尺寸
+ (UIImage *)resizeImage:(UIImage *)image WithMaxSize:(CGSize)maxSize;



/**
 弹框

 @param currVc 当前控制器
 @param content 提示内容
 @param leftMsg 左边按钮
 @param leftClickBlock 回调
 @param rightMsg 右边按钮
 @param rightClickBlock 回调
 */
+ (void)setUpAlterViewWith:(UIViewController *)currVc WithReadContent:(NSString *)content WithLeftMsg:(NSString *)leftMsg LeftBlock:(dispatch_block_t)leftClickBlock RightMsg:(NSString *)rightMsg RightBliock:(dispatch_block_t)rightClickBlock;



/**
 打开手电筒
 */
+ (void)openFlashlight;
/**
 关闭手电筒
 */
+ (void)closeFlashlight;



//屏幕高度 宽度
#define DCScreenH \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)

#define DCScreenW \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)

@end
