//
//  DCScanningViewController.m
//  CDDScanningCode
//
//  Created by 陈甸甸 on 2018/1/3.
//Copyright © 2018年 陈甸甸. All rights reserved.
//

#import "DCScanningViewController.h"

// Controllers

// Models

// Views
#import "DCFlashButton.h"
#import "DCScanIdentifyAreaView.h"
// Vendors

#import <AVFoundation/AVFoundation.h>
// Categories
#import "DCScanTool.h"
// Others

@interface DCScanningViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>

/* 用来捕捉管理活动的对象 */
@property (strong,nonatomic)AVCaptureSession *session;
/* 设备 */
@property (strong,nonatomic)AVCaptureDevice *device;
/* 捕获输入 */
@property (strong,nonatomic)AVCaptureDeviceInput *input;
/* 捕获输出 */
@property (strong,nonatomic)AVCaptureMetadataOutput *output;
/* 背景 */
@property (strong,nonatomic)AVCaptureVideoPreviewLayer *ffView;
/* 输出流 */
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
/* 自定义识别区View */
@property (strong , nonatomic)DCScanIdentifyAreaView *areaView;


@end

@implementation DCScanningViewController

#pragma mark - LazyLoad
- (DCFlashButton *)flashButton
{
    if (!_flashButton) {
        
        _flashButton = [DCFlashButton buttonWithType:UIButtonTypeCustom];
        _flashButton.alpha = 0;
        [_flashButton addTarget:self action:@selector(flashButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashButton;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpBase];
    
    [self setupCamera];
    
    [self setUpTipView];
    
}

#pragma mark - initialize
- (void)setUpBase
{
    self.title = @"二维码/条码";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"相册" forState:0];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(jumpPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}


#pragma mark - 提示按钮
- (void)setUpTipView
{
    _tipLabel = [UILabel new];
    _tipLabel.frame = CGRectMake(0, DCScreenW * 1.15, DCScreenW, 30);
    _tipLabel.text = @"请将条码放入框内即可自动扫描";
    _tipLabel.font = [UIFont systemFontOfSize:13];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
    [self.view addSubview:_tipLabel];
}

#pragma mark - 跳转到相册
- (void)jumpPhotoAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"无法访问相册" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        }];
        [alter addAction:okAction];
        
        [self presentViewController:alter animated:YES completion:nil];
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarScanBg"] forBarMetrics:UIBarMetricsDefault];
    picker.view.backgroundColor = [UIColor whiteColor];
    picker.delegate = self;
    
    [self showDetailViewController:picker sender:nil];
}

#pragma mark - <初始化相机设备等扫描控件>
- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    __weak typeof(self)weakSelf = self;
    [weakSelf setUpJudgmentWithScuessBlock:^{
        
        [self setUpPutInit]; //初始化
        
        [self setUpFullFigureView]; //背景面
        
        [self.session startRunning]; //开启扫描
        
    }]; //设备权限判断
}

#pragma mark - 扫描区域
- (void)setUpPutInit
{
    //初始化
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    _output = [AVCaptureMetadataOutput new];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设备输出流
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [_videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [AVCaptureSession new];
    [_session addOutput:_videoDataOutput]; //添加到sesson，识别光线强弱
    
    //限制扫描区域
    CGSize size = self.view.bounds.size;
    CGRect cropRect = CGRectMake(DCScreenW * 0.1, DCScreenW * 0.3, DCScreenW * 0.8, DCScreenW * 0.8);
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.;  //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = DCScreenW * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        _output.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,cropRect.origin.x/size.width,cropRect.size.height/fixHeight,cropRect.size.width/size.width);
    }else{
        CGFloat fixWidth = self.view.frame.size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        _output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,(cropRect.origin.x + fixPadding)/fixWidth,cropRect.size.height/size.height,cropRect.size.width/fixWidth);
    }
    
    
    //设置检测质量，质量越高扫描越精确，默认AVCaptureSessionPresetHigh
    if ([_device supportsAVCaptureSessionPreset:AVCaptureSessionPreset1920x1080]) {
        if ([_session canSetSessionPreset:AVCaptureSessionPreset1920x1080]) {
            [_session setSessionPreset:AVCaptureSessionPreset1920x1080];
        }
    }else if ([_device supportsAVCaptureSessionPreset:AVCaptureSessionPreset1280x720]) {
        if ([_session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
            [_session setSessionPreset:AVCaptureSessionPreset1280x720];
        }
    }
    
    //捕捉
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input]){
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output]){
        [_session addOutput:self.output];
    }
    
    
    // 扫码类型
    [self.output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil]];
}


#pragma mark - 全系背景View
- (void)setUpFullFigureView
{

    _ffView = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _ffView.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _ffView.frame = CGRectMake(0,0,DCScreenW,self.view.frame.size.height);
    [self.view.layer insertSublayer:self.ffView atIndex:0];
    
    _areaView = [[DCScanIdentifyAreaView alloc] initWithFrame:_ffView.bounds];
    _areaView.scanFrame = CGRectMake(DCScreenW * 0.1, DCScreenW * 0.3, DCScreenW * 0.8, DCScreenW * 0.8);
    [_ffView addSublayer:_areaView.layer];
    
    
    [self.view addSubview:self.flashButton];
    self.flashButton.frame = CGRectMake((DCScreenW - 25) * 0.5 , DCScreenW * 1.1 - 50, 20, 40); //手电筒的尺寸
}


- (void)flashButtonClick:(UIButton *)button
{
    if (button.selected == NO) {
        [DCScanTool openFlashlight];
    } else {
        [DCScanTool closeFlashlight];
    }
    
    button.selected = !button.selected;
}


#pragma mark - 设备权限判断
- (void)setUpJudgmentWithScuessBlock:(dispatch_block_t)openSession
{
    //权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        [DCScanTool setUpAlterViewWith:self WithReadContent:@"您未打开摄像权限。请在iPhone的“设置”-“隐私”-“相机”功能中，找到“申通APP”打开相机访问权限" WithLeftMsg:@"知道了" LeftBlock:nil RightMsg:@"前往" RightBliock:^{
            NSURL *qxUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if([[UIApplication sharedApplication] canOpenURL:qxUrl]) { //跳转到本应用APP的权限界面
                
                NSURL*url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
                
            }
        }];
        
    }else if(_device == nil){ //未找到设备
        
        [DCScanTool setUpAlterViewWith:self WithReadContent:@"未检测到相机设备，请您先检查下设备是否支持扫描" WithLeftMsg:@"好的" LeftBlock:nil RightMsg:nil RightBliock:nil];
        
    }else{ //识别到设备以及打开权限成功后回调
        
        !openSession ? : openSession(); //回调
    }
}

#pragma mark - <AVCaptureMetadataOutputObjectsDelegate>
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    if ([metadataObjects count] >0){
        
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        NSLog(@"扫描结果：%@",metadataObject.stringValue);
        if (metadataObject.stringValue.length != 0) {
            
            if (self.scanDelegate && [self.scanDelegate respondsToSelector:@selector(DCScanningSucessBackWithInfor:)]) {
                
                [self stopDeviceScanning]; //停止扫描
                
                [self.scanDelegate DCScanningSucessBackWithInfor:metadataObject.stringValue];
                __weak typeof(self)weakSelf = self;
                [DCScanTool setUpAlterViewWith:self WithReadContent:[NSString stringWithFormat:@"扫描结果为：%@",metadataObject.stringValue] WithLeftMsg:@"好的" LeftBlock:^{
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                } RightMsg:nil RightBliock:nil];
            }
            

        }
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [DCScanTool resizeImage:info[UIImagePickerControllerOriginalImage] WithMaxSize:CGSizeMake(1000, 1000)];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{ //异步
        
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
        
        CIImage *selImage = [[CIImage alloc] initWithImage:image];
        NSArray *features = [detector featuresInImage:selImage];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:features.count];
        for (CIQRCodeFeature *feature in features) {
            [arrayM addObject:feature.messageString];
        }
        __weak typeof(self)weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (arrayM.copy != nil && ![arrayM isKindOfClass:[NSNull class]] && arrayM.count != 0) {
                
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                
                [DCScanTool setUpAlterViewWith:self WithReadContent:[NSString stringWithFormat:@"扫描结果为：%@",arrayM.copy] WithLeftMsg:@"好的" LeftBlock:^{
                    
                    if (self.scanDelegate && [self.scanDelegate respondsToSelector:@selector(DCScanningSucessBackWithInfor:)]) {

                        [weakSelf.scanDelegate DCScanningSucessBackWithInfor:arrayM.copy];
                        
                        [weakSelf stopDeviceScanning]; //停止扫描
                        
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                    
                } RightMsg:nil RightBliock:nil];
                
            }else{
                
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                
                [DCScanTool setUpAlterViewWith:self WithReadContent:@"未能识别到任何二维码，请重新识别" WithLeftMsg:@"好的" LeftBlock:nil RightMsg:nil RightBliock:nil];
                
            }
        });
    });
}



#pragma mark - 停止扫描
- (void)stopDeviceScanning
{
    [_session stopRunning];
    _session = nil;
}


#pragma mark - <AVCaptureVideoDataOutputSampleBufferDelegate>
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    // 内存稳定调用这个方法的时候
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue]; //光线强弱度
    
    if (!self.flashButton.selected) {
        self.flashButton.alpha =  (brightnessValue < 1.0) ? 1 : 0;
    }
}

@end
