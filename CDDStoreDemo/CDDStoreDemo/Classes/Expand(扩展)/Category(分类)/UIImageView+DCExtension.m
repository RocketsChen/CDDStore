//
//  UIImageView+DCExtension.m
//  CDDMall
//
//  Created by apple on 2017/6/28.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "UIImageView+DCExtension.h"

#import "UIImage+DCCircle.h"
#import <UIImageView+WebCache.h>


@implementation UIImageView (DCExtension)


- (void)dc_setHeader:(NSString *)url
{
    WEAKSELF;
    [self sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.image = image ?[image dc_circleImage] : nil;
    }];
}


@end
