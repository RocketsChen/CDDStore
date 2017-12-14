//
//  DCKeepNewUserData.h
//  CDDMall
//
//  Created by apple on 2017/6/19.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCKeepNewUserData : NSObject

+ (void)keepNewDidFinished : (void(^)(DCUserInfo *userInfo))theNewData;

@end
