//
//  DCNavigationTabBar.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCNavigationTabBar.h"

@interface DCNavigationTabBar()
/** 滑动的View */
@property (nonatomic, strong) UIView *sliderView;
/** 顶部Button按钮数组 */
@property(nonatomic,strong)NSMutableArray<UIButton *> *buttonArray;
/** 底部下划线的宽度 */
@property(nonatomic,assign)CGFloat width;
/** 顶部Button按钮（选中） */
@property(nonatomic,strong)UIButton *selectedButton;


@end

@implementation DCNavigationTabBar

#pragma mark - 初始化标题
-(instancetype)initWithTitles:(NSArray *)titles
{
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)]) {
        self.buttonNormalTitleColor = [UIColor darkGrayColor];
        self.buttonSelectedTileColor = [UIColor redColor];
        [self setSubViewWithTitles:titles];
    }
    return self;
}

#pragma mark - 按钮
-(void)setSubViewWithTitles:(NSArray *)titles
{
    self.buttonArray = [[NSMutableArray alloc] init];
    for (int buttonIndex = 0 ; buttonIndex < titles.count; buttonIndex++) {
        NSString *titleString = titles[buttonIndex];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:self.buttonNormalTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:self.buttonSelectedTileColor forState:UIControlStateSelected];
        [btn setTitleColor:self.buttonSelectedTileColor forState:UIControlStateHighlighted | UIControlStateSelected];
        [btn setTitle:titleString forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        if(buttonIndex == 0){
            btn.selected = YES;
            self.selectedButton = btn;
        };
        [btn addTarget:self action:@selector(subButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = buttonIndex; //绑定tag
        [self addSubview:btn];
        [self.buttonArray addObject:btn];
    }
    
    self.sliderView = [[UIView alloc] init];
    self.sliderView.backgroundColor = self.buttonSelectedTileColor; //指示器颜色默认个选中按钮颜色一样
    [self addSubview:self.sliderView];
}

#pragma mark - 按钮选中
-(void)subButtonSelected:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    [self sliderViewAnimationWithButtonIndex:button.tag];
    if (self.didClickAtIndex) {
        self.didClickAtIndex(button.tag);
    }
}

#pragma mark - 根据索引滑动
-(void)scrollToIndex:(NSInteger)index
{
    self.selectedButton.selected = NO;
    self.buttonArray[index].selected = YES;
    self.selectedButton = self.buttonArray[index];
    [self sliderViewAnimationWithButtonIndex:index];
    
}
#pragma mark - 按钮滑动（动画）
-(void)sliderViewAnimationWithButtonIndex:(NSInteger)buttonIndex
{
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat buttonX = self.buttonArray[buttonIndex].center.x - (self.width /2);
        self.sliderView.frame = CGRectMake(buttonX, self.frame.size.height - 2.0f, self.width - 4, 2);
    }];
    
}

#pragma mark - 初始化Frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //底部指示器的Frame 和 button的Frame
    self.width =  50;
    CGFloat buttonWidth = 50;
    CGFloat buttonStartX = (([UIScreen mainScreen].bounds.size.width - 100) - 3 * buttonWidth) / 2;
    for (int buttonIndex = 0; buttonIndex < self.buttonArray.count; buttonIndex ++) {
        self.buttonArray[buttonIndex].frame = CGRectMake(buttonStartX +buttonIndex * buttonWidth, 0, buttonWidth, 44);
    }
    CGFloat buttonX = self.buttonArray[0].center.x - self.width / 2;
    self.sliderView.frame = CGRectMake(buttonX, self.frame.size.height - 2.0f, self.width - 4, 2);
}

@end

