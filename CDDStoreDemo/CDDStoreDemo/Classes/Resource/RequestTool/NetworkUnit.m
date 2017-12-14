//
//  NetworkUnit.m
//  zxwTool
//
//  Created by zhuxuwei on 14-3-28.
//  Copyright (c) 2014年 zxwo0o@qq.com. All rights reserved.
//

#import "NetworkUnit.h"

@implementation NetworkUnit


+(id)sharedInstance
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkUnit alloc] init];
        
        //[sharedInstance addObserverReachabilityChanged];
    });
    
    return sharedInstance;
}
/**
 *  @author zhangchun, 15-11-27 23:11:43
 *
 *  delay time
 *
 *   
 *  @return delayTime
 */
-(NSInteger)delayTime:(NetworkStatus) netStatus
{
    
    NSInteger delayTime =20;
    switch (netStatus) {
        case ReachableViaWiFi:
            delayTime = 10;
            break;
        case ReachableVia2G:
            delayTime = 20;

            break;
        case ReachableVia3G:
            delayTime = 15;

            break;
        case ReachableVia4G:
            delayTime = 10;

            break;
        default:
            break;
    }
    
    
    return delayTime;
}

#pragma mark - 获取网络状态
+(NSString *)getInternetStatus {

    Reachability *reachability  = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"wifi";
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = @"wifi";
            break;
        case ReachableVia2G:
            net = @"2G";
            break;
        case ReachableVia3G:
            net = @"3G";
            break;
        case ReachableVia4G:
            net = @"4G";
            break;
            
        case NotReachable:
            net = @"notReachable";
        default:
            break;
    }
    
    return net;
}


/**
 获取网络状态
 以前都用这个，但是发现IphoneX 不能[[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews]这个方法，所以改用上面的方法
 @return 网络状态
 */
//+(NETWORK_TYPE)getNetworkTypeFromStatusBar {
//    
//    UIApplication *app = [UIApplication sharedApplication];
//    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
//    NSNumber *dataNetworkItemView = nil;
//    
//    for (id subview in subviews) {
//        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
//            dataNetworkItemView = subview;
//            break;
//        }
//    }
//    NETWORK_TYPE nettype = NETWORK_TYPE_NONE;
//    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
//    int type = [num intValue];
//    if (type == 5) {
//        nettype = NETWORK_TYPE_WIFI;
//    }else if (type == 1){
//        nettype = NETWORK_TYPE_2G;
//    }else if (type == 2){
//        nettype = NETWORK_TYPE_3G;
//    }else if (type == 3){
//        nettype = NETWORK_TYPE_4G;
//    }
//    
//    return nettype;
//}


-(void)addObserverReachabilityChanged:(void(^)(NetworkStatus netStatus)) netStatusBlock{

    Reachability *_internetReach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [_internetReach startNotifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(reachabilityChangedNet:) name: kReachabilityChangedNotification object: nil];
    self.netStatusBlock = [netStatusBlock copy];
    
}

-(void)reachabilityChangedNet:(NSNotification* )note{
    
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (self.netStatusBlock) {
        self.netStatusBlock(netStatus);
    } 
}


@end

