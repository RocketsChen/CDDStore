//
//  DCCommentFooterCell.h
//  CDDMall
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCLIRLButton.h"

@interface DCCommentFooterCell : UICollectionViewCell

/* 全部 购买按钮 */
@property (strong , nonatomic)DCLIRLButton *commentFootButton;

/** 分割线 */
@property (nonatomic,assign)BOOL isShowLine;

@end
