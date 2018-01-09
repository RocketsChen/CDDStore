//
//  DCScanIdentifyAreaView.m
//  CDDScanningCode
//
//  Created by 陈甸甸 on 2018/1/4.
//Copyright © 2018年 陈甸甸. All rights reserved.
//



#import "DCScanIdentifyAreaView.h"

// Controllers

// Models

// Views

// Vendors
#import "DCScanTool.h"
// Categories

// Others

@interface DCScanIdentifyAreaView ()

/* 扫描图片 */
@property (strong , nonatomic)UIImageView *sqrImageView;
/* 定时器 */
@property (strong , nonatomic)NSTimer *timer;
/* 图片起始Y */
@property (assign , nonatomic)CGFloat qrImageLineY;;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;
/* 矩形框View */
@property (strong , nonatomic)UIView *bgView;
@end

static NSTimeInterval DCLineanimateDuration = 0.01;

@implementation DCScanIdentifyAreaView

#pragma mark - LazyLoad
- (UIImageView *)sqrImageView
{
    if (!_sqrImageView) {
        _sqrImageView = [[UIImageView alloc] init];
        _sqrImageView.image = [UIImage imageNamed:@"sqr_line"];
        _sqrImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _sqrImageView;
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpBase];

    }
    return self;
}



#pragma mark - base设置
- (void)setUpBase
{
    self.backgroundColor = [UIColor clearColor];
    
    //定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:DCLineanimateDuration target:self selector:@selector(sliding) userInfo:nil repeats:YES];
    [_timer fire];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置Frame
    _bgView = [[UIView alloc] initWithFrame:self.scanFrame];
    [self addSubview:_bgView];
    [_bgView addSubview:self.sqrImageView];

    self.sqrImageView.frame = CGRectMake(self.scanFrame.size.width * 0.1, self.scanFrame.origin.y, self.scanFrame.size.width * 0.8, 2);
    self.qrImageLineY = self.sqrImageView.frame.origin.y;

}

#pragma mark - 滑动
- (void)sliding
{
    __weak typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:DCLineanimateDuration animations:^{
        
        CGRect rect = weakSelf.sqrImageView.frame;
        rect.origin.y = _qrImageLineY;
        weakSelf.sqrImageView.frame = rect;
        
    } completion:^(BOOL finished) {
        
        CGFloat maxH = weakSelf.scanFrame.size.height;
        if (weakSelf.qrImageLineY > maxH) {
            
            weakSelf.qrImageLineY = 0;
        }
        
        weakSelf.qrImageLineY++;
    }];
}


#pragma mark - 给边框View蒙上一层遮罩
- (void)drawScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextSetRGBFillColor(ctx, 40 / 255.0,40 / 255.0,40 / 255.0,0.5);
    CGContextFillRect(ctx, rect);
}


#pragma mark - 制作边角
- (void)drawRect:(CGRect)rect
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect screenDrawRect = CGRectMake(0, 0, screenSize.width,screenSize.height);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawScreenFillRect:ctx rect:screenDrawRect];
    

    CGRect areaViewRectDrawRect = self.scanFrame;


    [self drawCenterClearRect:ctx rect:areaViewRectDrawRect];

    [self drawWhiteRect:ctx rect:areaViewRectDrawRect];

    [self drawCornerLineWithContext:ctx rect:areaViewRectDrawRect];
}



#pragma mark - 灰色背景
- (void)drawWhiteRect:(CGContextRef)ctx rect:(CGRect)rect {

    CGContextStrokeRect(ctx, rect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 1);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

#pragma mark - 挖去识别矩形框
- (void)drawCenterClearRect :(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextClearRect(ctx, rect);
}

#pragma mark - 画四个边角
- (void)drawCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect{
    
    CGContextSetLineWidth(ctx, 4);
    CGContextSetRGBStrokeColor(ctx, 237.0/255.0, 105.0/255.0, 0.0/255.0, 1);

    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x+0.7, rect.origin.y),
        CGPointMake(rect.origin.x+0.7 , rect.origin.y + 15)
    };
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y +0.7),CGPointMake(rect.origin.x + 15, rect.origin.y+0.7)};
    [self drawLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];
    
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x+ 0.7, rect.origin.y + rect.size.height - 15),CGPointMake(rect.origin.x +0.7,rect.origin.y + rect.size.height)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x , rect.origin.y + rect.size.height - 0.7) ,CGPointMake(rect.origin.x+0.7 +15, rect.origin.y + rect.size.height - 0.7)};
    [self drawLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];
    
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - 15, rect.origin.y+0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y +0.7 )};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width-0.7, rect.origin.y),CGPointMake(rect.origin.x + rect.size.width-0.7,rect.origin.y + 15 +0.7 )};
    [self drawLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    //右下角
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width -0.7 , rect.origin.y+rect.size.height+ -15),CGPointMake(rect.origin.x-0.7 + rect.size.width,rect.origin.y +rect.size.height )};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - 15 , rect.origin.y + rect.size.height-0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + rect.size.height - 0.7 )};
    [self drawLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    
    CGContextStrokePath(ctx);
}

#pragma mark - 画线
- (void)drawLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx {
    
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}


#pragma mark - 销毁定时器
- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - Setter Getter Methods

@end
