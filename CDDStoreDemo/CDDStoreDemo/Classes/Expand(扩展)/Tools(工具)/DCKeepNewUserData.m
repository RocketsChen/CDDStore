//
//  DCKeepNewUserData.m
//  CDDMall
//
//  Created by apple on 2017/6/19.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCKeepNewUserData.h"

@implementation DCKeepNewUserData

+ (void)keepNewDidFinished : (void(^)(DCUserInfo *userInfo))theNewData {
    
    __block DCUserInfo *userInfo  = UserInfoData;
    
    [DCUserInfo deleteObjects:[DCUserInfo findAll]];
    [userInfo save];
    !theNewData ? : theNewData(userInfo);
}


@end
