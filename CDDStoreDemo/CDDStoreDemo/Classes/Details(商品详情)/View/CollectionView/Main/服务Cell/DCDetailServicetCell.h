//
//  DCDetailServicetCell.h
//  CDDMall
//
//  Created by apple on 2017/6/25.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCLIRLButton.h"
@interface DCDetailServicetCell : UICollectionViewCell

/* 服务按钮 */
@property (strong , nonatomic)DCLIRLButton *serviceButton;
/* 服务标题 */
@property (strong , nonatomic)UILabel *serviceLabel;

@end
