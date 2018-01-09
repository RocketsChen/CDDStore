//
//  DCCenterServiceCell.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/13.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCGridItem;

@interface DCCenterServiceCell : UITableViewCell


/* 数据 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *serviceItemArray;

@end
