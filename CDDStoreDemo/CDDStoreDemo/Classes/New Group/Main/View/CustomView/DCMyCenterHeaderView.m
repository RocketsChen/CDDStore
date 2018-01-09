

//
//  DCMyCenterHeaderView.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/12.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCMyCenterHeaderView.h"

@interface DCMyCenterHeaderView()

@property (weak, nonatomic) IBOutlet UIButton *seeMyPriceButton;

@end

@implementation DCMyCenterHeaderView

#pragma mark - initialize
- (void)awakeFromNib {
    [super awakeFromNib];
    
    //圆角
    [DCSpeedy dc_chageControlCircularWith:_myIconButton AndSetCornerRadius:_myIconButton.dc_width * 0.5 SetBorderWidth:1 SetBorderColor:[UIColor whiteColor] canMasksToBounds:YES];
    _seeMyPriceButton.backgroundColor = RGB(252, 246, 213);
    [DCSpeedy dc_chageControlCircularWith:_seeMyPriceButton AndSetCornerRadius:10 SetBorderWidth:1 SetBorderColor:_seeMyPriceButton.backgroundColor canMasksToBounds:YES];
    
}

#pragma mark - 头像点击
- (IBAction)headButtonClick {
    !_headClickBlock ? : _headClickBlock();
}

#pragma mark - 朋友圈点击
- (IBAction)friendsCircleClick {
    !_friendCircleClickBlock ? : _friendCircleClickBlock();
}

#pragma mark - 我的好友点击
- (IBAction)myFriendClick {
    !_myFriendClickBlock ? : _myFriendClickBlock();
}

#pragma mark - 二维码点击
- (IBAction)qrCodeClick {
    !_qrClickBlock ? : _qrClickBlock();
}
- (IBAction)seeMyPriceClick {
    !_seePriceClickBlock ? : _seePriceClickBlock();
}

@end
