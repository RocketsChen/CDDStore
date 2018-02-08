//
//  DCCommentPicCell.m
//  CDDMall
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCommentPicCell.h"

// Controllers

// Models
#import "DCCommentPicItem.h"
// Views

// Vendors
#import "SDPhotoBrowser.h"
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCCommentPicCell ()<SDPhotoBrowserDelegate>

/* 昵称 */
@property (strong , nonatomic)UILabel *nickName;
/* 图片数量 */
@property (strong , nonatomic)UILabel *picNum;

/* imageArray */
@property (copy , nonatomic)NSArray *imagesArray;

@end

@implementation DCCommentPicCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    _pciImageView = [[UIImageView alloc] init];
    _pciImageView.contentMode = UIViewContentModeScaleAspectFit;
    _pciImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    [_pciImageView addGestureRecognizer:tap];
    [self addSubview:_pciImageView];
    
    _nickName = [[UILabel alloc] init];
    _nickName.font = PFR11Font;
    [self addSubview:_nickName];
    
    _picNum = [[UILabel alloc] init];
    _picNum.textColor = [UIColor whiteColor];
    _picNum.backgroundColor = RGB(60, 53, 44);
    _picNum.textAlignment = NSTextAlignmentCenter;
    _picNum.font = PFR10Font;
    [self addSubview:_picNum];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_pciImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:2];
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [_picNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_pciImageView);
        make.bottom.mas_equalTo(_pciImageView);
        make.size.mas_equalTo(CGSizeMake(30, 18));
    }];
    
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_pciImageView.mas_bottom)setOffset:2];
        make.left.mas_equalTo(_pciImageView);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setPicItem:(DCCommentPicItem *)picItem
{
    _picItem = picItem;
    
    [_pciImageView sd_setImageWithURL:[NSURL URLWithString:picItem.images[0]]];
    _picNum.text = [NSString stringWithFormat:@"%zd张",picItem.images.count];
    _nickName.text = [DCSpeedy dc_encryptionDisplayMessageWith:picItem.nickName WithFirstIndex:2];
    
    _imagesArray = picItem.images;
}

#pragma mark - 图片点击
- (void)tapImageView
{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = 0;
    browser.sourceImagesContainerView = self;
    browser.isCascadingShow = YES; //层叠
    browser.imageCount = _imagesArray.count;
    browser.delegate = self;
    [browser show];
}

#pragma mark - SDPhotoBrowserDelegate
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSURL *url = [NSURL new];
    if (index < _imagesArray.count) {
        url = [NSURL URLWithString:_imagesArray[index]];
    }
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return _pciImageView.image;
}


@end
