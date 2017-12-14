//
//  DCUserInfo.h
//  CDDMall
//
//  Created by apple on 2017/6/19.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "JKDBModel.h"

@interface DCUserInfo : JKDBModel

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *userimage;

@property (nonatomic, copy) NSString *birthDay;

@property (nonatomic, copy) NSString *defaultAddress;

@end
