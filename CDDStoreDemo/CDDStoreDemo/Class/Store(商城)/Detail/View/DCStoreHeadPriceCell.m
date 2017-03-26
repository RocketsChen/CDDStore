//
//  DCStoreHeadPriceCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreHeadPriceCell.h"

@implementation DCStoreHeadPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _icoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _icoImageView.clipsToBounds = YES;

}

- (IBAction)dismissButtonClick:(id)sender {
    
    !_dismissButtonClickBlock ? : _dismissButtonClickBlock();
}
@end
