//
//  DCGroupImageCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGroupImageCell.h"
#import <UIImageView+WebCache.h>

@interface DCGroupImageCell()
/* 图片 */
@property (strong , nonatomic)UIImageView *groupImageView;

@end

@implementation DCGroupImageCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI
{
    _groupImageView = [[UIImageView alloc] init];
    [self addSubview:_groupImageView];
    

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_groupImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:5];
        [make.right.mas_equalTo(self)setOffset:-5];
        [make.top.mas_equalTo(self)setOffset:5];
        [make.bottom.mas_equalTo(self)setOffset:-5];
    }];
    
}

- (void)setGroupImageUrl:(NSString *)groupImageUrl
{
    _groupImageUrl = groupImageUrl;
    WEAKSELF
    [_groupImageView sd_setImageWithURL:[NSURL URLWithString:groupImageUrl] placeholderImage:[UIImage imageNamed:@"default_50"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //圆角
        weakSelf.groupImageView.layer.cornerRadius = 12;
        weakSelf.groupImageView.layer.masksToBounds = YES;
        
    }];
    
}

@end
