//
//  DCDetailPicCell.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/24.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "DCItemImageCell.h"

@interface DCDetailPicCell : UICollectionViewCell

/* imageView */
@property (strong , nonatomic)UIImageView *itemImageView;

/** 保存到相册 */
@property (nonatomic, copy) dispatch_block_t savePhotoBlock;

@end
