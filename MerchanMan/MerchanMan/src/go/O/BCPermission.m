//
//  BCPermission.m
//  BatteryCam
//
//  Created by ocean on 2018/1/26.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "BCPermission.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <UserNotifications/UserNotifications.h>

@implementation BCPermission


//j推送通知权限
+(void)checkoutNotificationAuthorizationGrand:(void(^)(BCNotiAuthGrandType authType))permissionBlock {
    
    BOOL bigEqual_iOS10 = [[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0;
    BOOL bigEqual_iOS8 = [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0;
    if (bigEqual_iOS10) {
        //如果授权状态是notDetermined，那其他所有的setting都是0（notSupported）
        //如果授权状态是deny，那所有其他的setting都是1（disabled）
        //如果授权状态是authorized，其他设置的值才有意义
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
            UNAuthorizationStatus authStatus = settings.authorizationStatus;
            switch (authStatus) {
                case UNAuthorizationStatusNotDetermined:
                {
                    permissionBlock(BCNotiAuthGrandTypeNotDetermined);
                }
                    break;
                case UNAuthorizationStatusDenied:
                {
                    permissionBlock(BCNotiAuthGrandTypeDenied);
                }
                    break;
                case UNAuthorizationStatusAuthorized:
                {
                    permissionBlock(BCNotiAuthGrandTypeAuthorized);
                }
                    break;
                    
                default:
                    break;
            }
        }];
    } else if(bigEqual_iOS8){
        //iOS8、iOS9
        BOOL authStatus = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
        if (authStatus) {
            permissionBlock(BCNotiAuthGrandTypeAuthorized);
        }else{
            permissionBlock(BCNotiAuthGrandTypeDenied);
        }
    }
}


//请求
+(void)checkCameraAuthorizationGrand:(void(^)(void))permissonBlock noPermissonBlock:(void(^)(void))noPermissonBlock{
    //infoPlist 添加  Privacy - Camera Usage Description
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (videoAuthStatus) {
        case AVAuthorizationStatusNotDetermined:
        {
            //第一次提示用户授权
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted==YES) {
                    runOnMain(^{
                        permissonBlock();
                    });
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:
        {
            //通过授权
            permissonBlock();
            break;
        }
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:{
            if(noPermissonBlock){
                noPermissonBlock();
            }
            //NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [BCPermission showSetAlertView:@"申请权限" message:@"需要摄像头权限" prefsURL:nil];
        }
            break;
        default:
            break;
    }
}

+(void)checkMicrophoneAuthorizationGrand:(void(^)(void))permissonBlock noPermissonBlock:(void(^)(void))noPermissonBlock{
    //infoPlist 添加  Privacy - Microphone Usage Description
    AVAuthorizationStatus audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (audioAuthStatus) {
        case AVAuthorizationStatusNotDetermined:
        {
            //第一次提示用户授权
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                if (granted==YES) {
                    runOnMain(^{
                        permissonBlock();
                    });
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:
        {
            //通过授权
            permissonBlock();
            break;
        }
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:{
            if(noPermissonBlock){
                noPermissonBlock();
            }
            [BCPermission showSetAlertView:@"申请权限" message:@"需要麦克风权限" prefsURL:nil];
            
        }
            break;
        default:
            break;
    }
}

+(void)checkPhotoAlbumAuthorizationGrand:(void(^)(void))permissonBlock noPermissonBlock:(void(^)(void))noPermissonBlock{
    //infoPlist 添加  Privacy - Photo Library Usage Description和Privacy - Photo Library Additions Usage Description
    PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthStatus) {
        case PHAuthorizationStatusNotDetermined:
        {
            //第一次提示用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if(status == PHAuthorizationStatusAuthorized){
                    runOnMain(^{
                        permissonBlock();
                    });
                }
            }];
            break;
        }
        case PHAuthorizationStatusAuthorized:
        {
            //已经通过授权
            permissonBlock();
            break;
        }
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:{
            noPermissonBlock();
            //提示跳转相册授权设置
            [BCPermission showSetAlertView:@"申请权限" message:@"需要相册访问授权" prefsURL:nil];
            break;
        }
        default:
            break;
    }
}

+(void)showSetAlertView:(NSString *)title message:(NSString *)message prefsURL:(NSString *)prefsURL{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [YFMerchanUtil gotoAppSetting];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:setAction];
    runOnMain(^{
        UIViewController * vc =  frontestWindow().rootViewController.presentedViewController;
        if(vc)
            [vc presentViewController:alertVC animated:YES completion:nil];
        else
            [frontestWindow().rootViewController presentViewController:alertVC animated:YES completion:nil];
    });

}

@end
