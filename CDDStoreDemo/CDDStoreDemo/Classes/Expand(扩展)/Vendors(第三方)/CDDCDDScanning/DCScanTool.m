//
//  DCScanTool.m
//  CDDScanningCode
//
//  Created by 陈甸甸 on 2018/1/3.
//  Copyright © 2018年 陈甸甸. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "DCScanTool.h"

@implementation DCScanTool

#pragma mark - 调整图片尺寸
+ (UIImage *)resizeImage:(UIImage *)image WithMaxSize:(CGSize)maxSize{
    
    if (image.size.width < maxSize.width && image.size.height < maxSize.height) {
        return image;
    }
    maxSize = (maxSize.width == 0)  ?  CGSizeMake(1000, 1000) : maxSize;
    CGFloat xScale = maxSize.width / image.size.width;
    CGFloat yScale = maxSize.height / image.size.height;
    CGFloat scale = MIN(xScale, yScale);
    CGSize size = CGSizeMake(image.size.width * scale, image.size.height * scale);

    UIGraphicsBeginImageContext(size);

    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];

    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return result;
}



#pragma mark - 弹框
+ (void)setUpAlterViewWith:(UIViewController *)currVc WithReadContent:(NSString *)content WithLeftMsg:(NSString *)leftMsg LeftBlock:(dispatch_block_t)leftClickBlock RightMsg:(NSString *)rightMsg RightBliock:(dispatch_block_t)rightClickBlock
{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"温馨提示" message:content preferredStyle:UIAlertControllerStyleAlert];
    
    if (leftMsg.length != 0) {
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:leftMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            !leftClickBlock ? : leftClickBlock();
        }];
        [alter addAction:okAction];
        
    }

    if (rightMsg.length != 0) {
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:rightMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            !rightClickBlock ? : rightClickBlock();
        }];
        [alter addAction:okAction];
        
    }
    
    [currVc presentViewController:alter animated:YES completion:nil];
}


#pragma mark - 打开手电筒
+ (void)openFlashlight {
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    if ([captureDevice hasTorch]) {
        BOOL locked = [captureDevice lockForConfiguration:&error];
        if (locked) {
            captureDevice.torchMode = AVCaptureTorchModeOn;
            [captureDevice unlockForConfiguration];
        }
    }
}

#pragma mark - 关闭手电筒
+ (void)closeFlashlight {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}



@end
