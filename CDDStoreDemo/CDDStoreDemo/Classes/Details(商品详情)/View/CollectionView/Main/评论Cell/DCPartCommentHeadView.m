//
//  DCPartCommentHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/28.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCPartCommentHeadView.h"

// Controllers

// Models

// Views

// Vendors

// Categories
#import "UIImage+DCCircle.h"
// Others
//100

@interface DCPartCommentHeadView ()

/* 文字评论 */
@property (strong , nonatomic)UIView *commentTextView;

/* 图片头部 */
@property (strong , nonatomic)UIView *picHeadView;
/* 图片数量 */
@property (strong , nonatomic)UILabel *picNumLabel;
/* 指示按钮 */
@property (strong , nonatomic)UIButton *indicateButton;

/* 头像 */
@property (strong , nonatomic)UIImageView *iconImageView;
/* 昵称 */
@property (strong , nonatomic)UILabel *nickNameLabel;
/* 评论内容 */
@property (strong , nonatomic)UILabel *contentLabel;
/* 时间 */
@property (strong , nonatomic)UILabel *timeLabel;
@end

@implementation DCPartCommentHeadView

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
    
    [self setUpTextComment];
    
    [self setUpPicHead];
}

#pragma mark - 文字评论
- (void)setUpTextComment
{
    _commentTextView = [[UIView alloc] init];
    [self addSubview:_commentTextView];

    
    DCUserInfo *userInfo = UserInfoData;
    _iconImageView = [[UIImageView alloc] init];
    UIImage *image = (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) ? [[UIImage imageNamed:@"GM_user_default_home"] dc_circleImage] : [[DCSpeedy Base64StrToUIImage:userInfo.userimage] dc_circleImage];
    _iconImageView.image = image;

    [_commentTextView addSubview:_iconImageView];
    
    
    _nickNameLabel = [[UILabel alloc] init];
    _nickNameLabel.font = PFR11Font;
    NSString *nickName = (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) ? @"RocketsChen" : userInfo.nickname;
    _nickNameLabel.text = [DCSpeedy dc_encryptionDisplayMessageWith:nickName WithFirstIndex:2];
    [_commentTextView addSubview:_nickNameLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = PFR12Font;
    _contentLabel.text = @"如果项目对你有所帮助，别忘了点星支持下！";
    [_commentTextView addSubview:_contentLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = [UIColor lightGrayColor];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"YY-MM-dd";
    NSString *currentDateStr = [fmt stringFromDate:[NSDate date]];
    _timeLabel.text = currentDateStr;
    _timeLabel.font = PFR10Font;
    [self addSubview:_timeLabel];
}

#pragma mark - 图片头部
- (void)setUpPicHead
{
    _picHeadView = [[UIView alloc] init];
    [self addSubview:_picHeadView];
    
    _picNumLabel = [[UILabel alloc] init];
    _picNumLabel.font = PFR12Font;
    [_picHeadView addSubview:_picNumLabel];
    
    _indicateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_indicateButton setImage:[UIImage imageNamed:@"icon_charge_jiantou"] forState:UIControlStateNormal];
    [_picHeadView addSubview:_indicateButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
 
    //图片头部布局
    [self setUpLayoutpicHeadViewSubviews];
    //文字评论布局
    [self setUpLayoutcommentTextViewSubviews];
}


#pragma mark - 图片头部布局
- (void)setUpLayoutpicHeadViewSubviews
{
    [_picHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(25);
    }];
    
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.bottom.mas_equalTo(_picHeadView.mas_top);
        make.top.mas_equalTo(self);
    }];
    
    [_picNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.centerY.mas_equalTo(_picHeadView);
    }];
    
    [_indicateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(_picHeadView);
    }];
}

#pragma mark - 文字评论布局
- (void)setUpLayoutcommentTextViewSubviews
{
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_commentTextView)setOffset:DCMargin];
        make.top.mas_equalTo(_commentTextView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_iconImageView.mas_right)setOffset:5];
        make.centerY.mas_equalTo(_iconImageView);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView);
        [make.right.mas_equalTo(_commentTextView)setOffset:-DCMargin];
        [make.top.mas_equalTo(_iconImageView.mas_bottom)setOffset:5];
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentLabel.mas_bottom);
        make.left.mas_equalTo(_contentLabel);
        make.bottom.mas_equalTo(_commentTextView);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setPicNum:(NSString *)picNum
{
    _picNum = picNum;
    
    _picNumLabel.text = [NSString stringWithFormat:@"有图评价（%@）",picNum];
    
}



@end
