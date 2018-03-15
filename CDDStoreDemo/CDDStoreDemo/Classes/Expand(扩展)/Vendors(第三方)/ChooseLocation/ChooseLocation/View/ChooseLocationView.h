//
//  ChooseLocationView.h
//  ChooseLocation
//
//  Created by Sekorm on 16/8/22.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseLocationView : UIView

@property (nonatomic, copy) NSString * address;

@property (nonatomic, copy) void(^chooseFinish)(void);

/* 省ID */
@property (nonatomic, copy) NSString *ProvinceId;
/* 市ID */
@property (nonatomic, copy) NSString *CityId;
/* 区ID */
@property (nonatomic, copy) NSString *DistrictId;


@end
