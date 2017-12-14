//
//  DCAttributeItemCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCAttributeItemCell.h"

// Controllers

// Models
#import "DCFiltrateItem.h"
#import "DCContentItem.h"
// Views

// Vendors
#import "Masonry.h"
// Categories

// Others
#import "DCSpeedy.h"

@interface DCAttributeItemCell ()
/* item按钮 */
@property (strong , nonatomic)UIButton *contentButton;

@end

@implementation DCAttributeItemCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _contentButton.enabled = NO;
    [self addSubview:_contentButton];
    _contentButton.titleLabel.font = PFR12Font;
    [_contentButton setTitleColor:[UIColor blackColor] forState:0];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - Setter Getter Methods
- (void)setContentItem:(DCContentItem *)contentItem
{
    _contentItem = contentItem;
    [_contentButton setTitle:contentItem.content forState:0];
    
    if (contentItem.isSelect) {
        [_contentButton setImage:[UIImage imageNamed:@"isSelectYes"] forState:0];
        [_contentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _contentButton.backgroundColor = [UIColor whiteColor];

        [DCSpeedy dc_chageControlCircularWith:self AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:[UIColor redColor] canMasksToBounds:YES];
    }else{
        
        [_contentButton setImage:nil forState:0];
        [_contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _contentButton.backgroundColor = RGB(230, 230, 230);
        
        [DCSpeedy dc_chageControlCircularWith:self AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:RGB(230, 230, 230) canMasksToBounds:YES];
    }
}


@end
