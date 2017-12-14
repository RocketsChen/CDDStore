//
//  GQPanVCTransition.m
//  GQPanVCTransitionDemo
//
//  Created by tusm on 16/4/30.
//  Copyright © 2016年 gaoqi. All rights reserved.
//

#import "GQGesVCTransition.h"
#import <objc/runtime.h>

/**
 *  BOOL的get set方法
 *
 *  @param _getter_      get方法
 *  @param _setter_      set方法
 *  @param _association_ 关联策略
 *  @param _type_        值类型
 *
 *  @return get:_type_  set:void
 */

#define GQ_DYNAMIC_PROPERTY_BOOL(_getter_, _setter_)\
- (void)_setter_:(BOOL)object{\
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, @(object), OBJC_ASSOCIATION_ASSIGN); \
    [self didChangeValueForKey:@#_getter_]; \
}\
-(BOOL)_getter_{\
    return [objc_getAssociatedObject(self, @selector(_setter_:)) boolValue];\
}\

/**
 *  NSObject的get set方法
 *
 *  @param _getter_      get方法
 *  @param _setter_      set方法
 *  @param _association_ 关联策略
 *  @param _type_        值类型
 *
 *  @return get:_type_  set:void
 */

#define GQ_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}

/**
 *  根据selector获取methold
 *
 *  @param c              类名
 *  @param selector       方法名
 *  @param instanceMethod 是否为实例方法
 *
 *  @return 方法
 */
#define __getMethod(_class, _value, _instanceMethod) ({\
    Method _method =  class_getInstanceMethod(_class , _value); \
    _instanceMethod = YES; \
    if(!_method){\
        _method = class_getClassMethod(_class, _value);\
        _instanceMethod = NO;\
    }\
    _method;\
})

/**
 *  设置一个默认的全局使用的手势类型，默认是全屏向左拖动模式
 */
static GQGesVCTransitionType __GQGesVCTransitionType = GQGesVCTransitionTypePanWithPercentLeft;

/**
 *  设置一个当界面有scrollview时,scrollview滑动到左边界时是否响应返回手势  默认为NO
 */
static BOOL __GQGesRequestFailLoopScrollView = NO;

/**
 *  设置一个默认的全局使用的百分比，默认是1.0
 */
static float __GQGesVCTransitionPercent = 1.0f;

/**
 *  导航栏拖动手势key
 */
NSString * const k__GQGesVCTransition_GestureRecognizer = @"__GQGesVCTransition_GestureRecognizer";

/**
 *  view是否响应手势key
 */
NSString * const kGQGesVCTransition_AbleViewTransition = @"__GQGesVCTransition_AbleViewTransition";

/**
 *  拖动手势依赖的nav
 */
NSString * const kGQGesVCTransition_NavController_OfPan = @"__GQGesVCTransition_NavController_OfPan";

/**
 *  判断是否修改新方法的IMP
 *
 *  @param c                类名
 *  @param exchangedSEL     修改成的方法名
 *  @param oldMethod        老方法
 *  @param isInstanceMethod 老方法是否为实例方法
 *
 *  @return  yes or no
 */
static BOOL __JudgeClassSelectorExchange(Class c, SEL exchangedSEL, Method oldMethod , BOOL isInstanceMethod)
{
    BOOL instanceMethod = YES;
    Method exchangedMethod = __getMethod(c, exchangedSEL, instanceMethod);
    IMP exchangedIMP = method_getImplementation(exchangedMethod);
    
    IMP oldIMP = method_getImplementation(oldMethod);
    
    if (!exchangedMethod||!oldMethod||instanceMethod != isInstanceMethod) {
        return NO;
    }
    
    NSString *exchangedIMPIva = [NSString stringWithFormat:@"%p",exchangedIMP];
    NSString *oldIMPIva = [NSString stringWithFormat:@"%p",oldIMP];
    if ([exchangedIMPIva isEqualToString:oldIMPIva]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - hook大法
//静态就交换静态，实例方法就交换实例方法  (交换方法的IMP)   调用的是老方法名  但跑的是我们的方法
static BOOL __GQGesVCTransition_SwizzleIMP(Class c, SEL oldSEL, SEL newSEL)
{
    //获取方法
    BOOL isOldInstanceMethod = YES;
    BOOL isNewInstanceMethod = YES;
    Method oldMethod = __getMethod(c, oldSEL , isOldInstanceMethod);
    Method newMethod = __getMethod(c, newSEL , isNewInstanceMethod);
    
    //都没找到？ oldMethod与newMethod不是同一类型方法？ 那就返回
    if (!oldMethod||!newMethod||isOldInstanceMethod != isNewInstanceMethod) {
        return NO;
    }
    
    //自身已经有了就添加不成功，直接交换即可
    if(class_addMethod(c, oldSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        //添加成功一般情况是因为，oldSEL本身是在self的父类里。这里添加成功了一个继承方法。  category的话是永远都能添加上去，谁都不能保证谁覆盖谁  如果是category复写另外一个category的方法的话使用method_exchangeImplementations直接替换
        class_replaceMethod(c, newSEL, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    }else{
        method_exchangeImplementations(oldMethod, newMethod);
    }
    return __JudgeClassSelectorExchange(c, newSEL, oldMethod, isOldInstanceMethod);
}

#pragma mark - UIView category implementation

@implementation UIView(__GQGesVCTransition)

- (void)disableGQVCTransition
{
    [self setDisableVCTransition:YES];
}

- (void)enableGQVCTransition
{
    [self setDisableVCTransition:NO];
}

GQ_DYNAMIC_PROPERTY_BOOL(disableVCTransition, setDisableVCTransition);

@end

#pragma mark - UIGestureRecognizer category interface
@interface UIGestureRecognizer(__GQGesVCTransition)

@end

#pragma mark - UIGestureRecognizer category implementation
@implementation UIGestureRecognizer(__GQGesVCTransition)

GQ_DYNAMIC_PROPERTY_OBJECT(__GQGesVCTransition_NavController, set__GQGesVCTransition_NavController, RETAIN_NONATOMIC, UINavigationController*);

@end

#pragma mark - UIPercentDrivenInteractiveTransition category
@interface UIPercentDrivenInteractiveTransition(__GQGesVCTransition)

@end

@implementation UIPercentDrivenInteractiveTransition(__GQGesVCTransition)

- (void)handleNavigationTransition:(UIPanGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //做个样子,也用来防止如果这个api系统改了名字，我们这边还是可用的。
        [recognizer.__GQGesVCTransition_NavController popViewControllerAnimated:YES];
    }
}

@end

#pragma mark - UINavigationController category interface
@interface UINavigationController(_GQGesVCTransition)<UIGestureRecognizerDelegate>

- (void)__GQGesVCTransition_ViewDidLoad;

@end

#pragma mark - UINavigationController category implementation
@implementation UINavigationController(_GQGesVCTransition)

#pragma mark getter and setter

GQ_DYNAMIC_PROPERTY_OBJECT(__GQGesVCTransition_panGestureRecognizer, set__GQGesVCTransition_panGestureRecognizer, RETAIN_NONATOMIC, UIPanGestureRecognizer*);

#pragma mark 我自己的方法
- (void)__GQGesVCTransition_ViewDidLoad
{
    //调用viewDidLoad
    [self __GQGesVCTransition_ViewDidLoad];
    
    //手势初始化
    if (!self.__GQGesVCTransition_panGestureRecognizer&&[self.interactivePopGestureRecognizer.delegate isKindOfClass:[UIPercentDrivenInteractiveTransition class]]) {
        UIPanGestureRecognizer *gestureRecognizer = nil;
        if (__GQGesVCTransitionType == GQGesVCTransitionTypeScreenEdgePan) {
            gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
            ((UIScreenEdgePanGestureRecognizer*)gestureRecognizer).edges = UIRectEdgeAll;
        }else{
            gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
        }
        
        gestureRecognizer.delegate = self;
        gestureRecognizer.__GQGesVCTransition_NavController = self;
        
        self.__GQGesVCTransition_panGestureRecognizer = gestureRecognizer;
        
        //禁用系统的手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    //在nav的view上添加我们的手势
    [self.view addGestureRecognizer:self.__GQGesVCTransition_panGestureRecognizer];
}

#pragma mark GestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer
{
    UIView* view = recognizer.view;
    if (__GQGesRequestFailLoopScrollView&&recognizer.__GQGesVCTransition_NavController) {
        CGPoint loc = [recognizer locationInView:view];
        UIView* superView = [view hitTest:loc withEvent:nil];
        while (superView != nil) {
            if ([[superView class] isSubclassOfClass:[UIScrollView class]]&&((UIScrollView*)superView).scrollEnabled&&((UIScrollView*)superView).contentSize.width > ((UIScrollView*)superView).frame.size.width&&((UIScrollView*)superView).contentOffset.x>0) {
                return NO;
            }
            superView = superView.superview;
        }
    }
    
    UINavigationController *navVC = self;
    if ([navVC.transitionCoordinator isAnimated]||navVC.viewControllers.count < 2) {
        return NO;
    }
    
    if (view.disableVCTransition) {
        return NO;
    }
    
    CGPoint loc = [recognizer locationInView:view];
    UIView* subview = [view hitTest:loc withEvent:nil];
    UIView *superView = subview;
    while (superView!=view) {
        if (superView.disableVCTransition) { //这个view忽略了拖返
            return NO;
        }
        superView = superView.superview;
    }
    
    //如果开始方向不对即不启用
    if (__GQGesVCTransitionType==GQGesVCTransitionTypePanWithPercentRight||__GQGesVCTransitionType==GQGesVCTransitionTypePanWithPercentLeft){
        CGPoint velocity = [recognizer velocityInView:navVC.view];
        if(velocity.x<=0) {
            return NO;
        }
        
        CGPoint translation = [recognizer translationInView:navVC.view];
        translation.x = translation.x==0?0.00001f:translation.x;
        CGFloat ratio = (fabs(translation.y)/fabs(translation.x));
        
        if ((translation.y>0&&ratio>0.618f)||(translation.y<0&&ratio>0.2f)||translation.x == 0) {
            return NO;
        }
    }
    return YES;
}

//根据手势的类型和百分比决定是否接受手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UINavigationController *navVC = self;
    CGPoint point = [touch locationInView:navVC.view];
    if (__GQGesVCTransitionType == GQGesVCTransitionTypePanWithPercentLeft) {
        if (point.x/[UIScreen mainScreen].bounds.size.width <=__GQGesVCTransitionPercent) {
            return YES;
        }
    }else if (__GQGesVCTransitionType == GQGesVCTransitionTypePanWithPercentRight){
        if (fabs(point.x/[UIScreen mainScreen].bounds.size.width-1) <=__GQGesVCTransitionPercent) {
            return YES;
        }
    }
    return NO;
}
@end

@implementation UINavigationController(DisableVCTransition)

// 设置导航控制器是否响应手势
- (void)enabledGQVCTransition:(BOOL)enabled
{
    self.__GQGesVCTransition_panGestureRecognizer.enabled = enabled;
}

@end

#pragma mark - UIScrollView category ，可让scrollView在一个良好的关系下并存
@interface UIScrollView(__VCTransistion)<UIGestureRecognizerDelegate>

@end

@implementation UIScrollView(__VCTransistion)

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer
{
    //取消scrollview上面的自带手势
    if (__GQGesRequestFailLoopScrollView&&!self.disableVCTransition&&!recognizer.__GQGesVCTransition_NavController) {
        if ([recognizer isEqual:self.panGestureRecognizer]) {
            UIView *cell = [recognizer view];
            CGPoint velocity = [recognizer velocityInView:cell];
            //如果scrollview滑动到左边界并且是往左滑
            CGPoint translation = [recognizer translationInView:cell];
            if (translation.x == 0) {
                return YES;
            }
            if (self.contentOffset.x<=0&&velocity.x>0) {
                CGFloat ratio = (fabs(translation.x)/fabs(translation.y));
                if ((translation.y>=0&&ratio>0.618f)||(translation.y<0&&ratio>0.2f)) {
                    return NO;
                }
            }
        }
    }
    return YES;
}

//在scrollview上干掉我们的手势，避免手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isEqual:self.panGestureRecognizer])
    {
        //如果此scrollView有旋转就要忽略了
        if (CGAffineTransformEqualToTransform(CGAffineTransformMakeRotation(-M_PI*0.5),self.transform)||CGAffineTransformEqualToTransform(CGAffineTransformMakeRotation(M_PI*0.5),self.transform))
        {
            return NO;
        }
        else if (self.contentSize.width>self.frame.size.width)
        {
            return NO;
        }
        if (otherGestureRecognizer.__GQGesVCTransition_NavController)
        {
            //说明这是我们的手势  干掉
            return YES;
        }
    }
    return NO;
}

@end

@implementation GQGesVCTransition

+ (void)validateGesBack
{
    [self validateGesBackWithType:GQGesVCTransitionTypePanWithPercentLeft withScreenWidthPercent:0 withRequestFailToLoopScrollView:NO];
}

+ (void)validateGesBackWithType:(GQGesVCTransitionType)type withRequestFailToLoopScrollView:(BOOL)requestFail
{
    [self validateGesBackWithType:type withScreenWidthPercent:0 withRequestFailToLoopScrollView:requestFail];
}

+ (void)validateGesBackWithType:(GQGesVCTransitionType)type withScreenWidthPercent:(NSNumber *)percent
{
    [self validateGesBackWithType:type withScreenWidthPercent:percent withRequestFailToLoopScrollView:NO];
}

+ (void)validateGesBackWithType:(GQGesVCTransitionType)type withScreenWidthPercent:(NSNumber *)percent withRequestFailToLoopScrollView:(BOOL)requestFail
{
    //IOS7以下不可用
    if ([[[UIDevice currentDevice] systemVersion]floatValue]<7.0) {
        return;
    }
    
    //启用hook，自动对每个导航器开启拖返功能，整个程序的生命周期只允许执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //设置记录type,并且执行hook
        __GQGesVCTransitionType = type;
        
        __GQGesRequestFailLoopScrollView = requestFail;
        
        if (percent != 0) {
            __GQGesVCTransitionPercent = [percent floatValue];
        }
        
        __GQGesVCTransition_SwizzleIMP([UINavigationController class],@selector(viewDidLoad),@selector(__GQGesVCTransition_ViewDidLoad));
    });
}
@end
