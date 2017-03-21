//
//  DCStoreDetailViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCStoreDetailViewController.h"

#import "DCStoreMainViewController.h"
#import "DCStoreIntroduceViewController.h"
#import "DCStoreCommentViewController.h"

#import "DCNavigationTabBar.h"

@interface DCStoreDetailViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
/** 自定义导航条上面的View */
@property(nonatomic,strong)DCNavigationTabBar *navigationTabBar;

/** 自控制器数组 */
@property(nonatomic,strong)NSArray<UIViewController *> *subViewControllers;


@end

@implementation DCStoreDetailViewController

#pragma mark - 懒加载
- (DCNavigationTabBar *)navigationTabBar
{
    if (!_navigationTabBar) {
        _navigationTabBar = [[DCNavigationTabBar alloc]initWithTitles:@[@"商品",@"详情",@"评价"]];
        
        __weak typeof(self) weakSelf = self;
        [self.navigationTabBar setDidClickAtIndex:^(NSInteger index){
            [weakSelf navigationDidSelectedControllerIndex:index];
        }];
    }
    return _navigationTabBar;
}

-(NSArray *)subViewControllers
{
    if (!_subViewControllers) {
        //创建子控制器
        DCStoreMainViewController *storeMainVc = [[DCStoreMainViewController alloc] init];
        
        DCStoreIntroduceViewController *storeIntroduceVc = [[DCStoreIntroduceViewController alloc] init];
        
        DCStoreCommentViewController *storeCommentVc = [[DCStoreCommentViewController alloc] init];
        
        self.subViewControllers = @[storeMainVc,storeIntroduceVc,storeCommentVc];
    }
    return _subViewControllers;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.navigationTabBar;
    self.delegate = self;
    self.dataSource = self;
    [self setViewControllers:@[self.subViewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil]; //默认第一个控制器
    
}

#pragma mark - <UIPageViewControllerDelegate>
/**
 在这两个方法中就是初始化和生成制定下一页的viewController
 */
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //控制器索引
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self.subViewControllers objectAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //控制器索引
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == NSNotFound || index == self.subViewControllers.count - 1) {
        return nil;
    }
    index++;
    return [self.subViewControllers objectAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.viewControllers[0];
    NSUInteger index = [self.subViewControllers indexOfObject:viewController];
    [self.navigationTabBar scrollToIndex:index];
    
}

#pragma mark - 点击控制器跳转
- (void)navigationDidSelectedControllerIndex:(NSInteger)index {
    [self setViewControllers:@[[self.subViewControllers objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

@end
