


//
//  BCRechabilityVM.m
//  BatteryCam
//
//  Created by yf on 2018/6/29.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "BCRechabilityVM.h"
#import "Reachability.h"
#import "RealReachability.h"
#import "IUtil.h"
NSString *const BC_NETWORK_UNKOWN=@"BCN_ETWORK_UNKOWN";
NSString *const BC_NETWORK_NONE=@"BCN_ETWORK_NONE";
NSString *const BC_NETWORK_WWAN=@"BCN_ETWORK_WWAN";
NSString *const BC_NETWORK_WIFI=@"BCN_ETWORK_WIFI";
@interface BCRechabilityVM()
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@end
@implementation BCRechabilityVM

+(void)checkNetworkStatus{
    [BCRechabilityVM.shared checkNetworkStatus];
}
+(NSString *)curNetworkStatusDesc{
    return [BCRechabilityVM.shared curNetworkStatusDesc];
}
+(NetworkStatus)curNetworkStatus{
    return [BCRechabilityVM.shared curNetworkStatus];
}
+(BOOL)curNetworkNormal{
    return [self curNetworkStatus] != NotReachable;
}


+(void)listenNetWorkingStatus2{
    [BCRechabilityVM.shared listenNetWorkingStatus2];
}
+(instancetype)shared{
    static dispatch_once_t onceToken;
    static BCRechabilityVM *vm;
    dispatch_once(&onceToken, ^{
        vm=[[BCRechabilityVM alloc]init];
    });
    return vm;
}


-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}



#pragma mark - network  reachability


-(void)listenNetWorkingStatus2{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    // 设置网络检测的站点
    //    NSString *remoteHostName = @"www.apple.com";
    //
    //    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    //    [self.hostReachability startNotifier];
    //    [self updateInterfaceWithReachability:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    //    [self updateInterfaceWithReachability:self.internetReachability];
}

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus) {
        case 0:
            //            [iPop toast:@"NotReachable----无网络"];
            [iNotiCenter postNotificationName:BC_NETWORK_NONE object:nil];
            break;
            
        case 1:
            //           [iPop toast:@"ReachableViaWiFi----WIFI"];
            [iNotiCenter postNotificationName:BC_NETWORK_WIFI object:nil];
            break;
            
        case 2:
            //            [iPop toast:@"ReachableViaWWAN----蜂窝网络"];
            [iNotiCenter postNotificationName:BC_NETWORK_WWAN object:nil];
            break;
            
        default:
            break;
    }
    
}
-(void)checkNetworkStatus{
    //    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    //    [self realNetworkingStatus:status];
    [self updateInterfaceWithReachability:self.internetReachability];
}
-(NSString *)curNetworkStatusDesc{
    NetworkStatus status = self.curNetworkStatus;
    switch(status){
        case NotReachable:
            return @"No Network";
        case ReachableViaWiFi:
            return @"WiFi";
        case ReachableViaWWAN:
            return @"WWAN";
        default:
            break;
    }
    return @"Unknow Network";
}
-(NetworkStatus)curNetworkStatus{
    return self.internetReachability.currentReachabilityStatus;
}
#pragma mark - network  realReachability
-(void)listenNetWorkingStatus{
    [GLobalRealReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    [self checkNetworkStatus];
}


- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    [self realNetworkingStatus:status];
}
-(void)realNetworkingStatus:(ReachabilityStatus)status{
    switch (status)
    {
        case RealStatusUnknown:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusUnknown");
            [iNotiCenter postNotificationName:BC_NETWORK_UNKOWN object:nil];
            break;
        }
            
        case RealStatusNotReachable:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusNotReachable");
            [iNotiCenter postNotificationName:BC_NETWORK_NONE object:nil];
            break;
        }
            
        case RealStatusViaWWAN:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusViaWWAN");
            [iNotiCenter postNotificationName:BC_NETWORK_WWAN object:nil];
            break;
        }
        case RealStatusViaWiFi:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusViaWiFi");
            [iNotiCenter postNotificationName:BC_NETWORK_WIFI object:nil];
            break;
        }
        default:
            break;
    }
}


@end
