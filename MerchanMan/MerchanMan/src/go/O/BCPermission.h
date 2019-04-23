//
//  BCPermission.h
//  BatteryCam
//
//  Created by ocean on 2018/1/26.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BCNotiAuthGrandType) {
    
    BCNotiAuthGrandTypeNotDetermined, //>iOS10, 用户还没有点
    BCNotiAuthGrandTypeDenied,        //用户点了不同意
    BCNotiAuthGrandTypeAuthorized     //用户点了同意
};

@interface BCPermission : NSObject

//相机权限
+(void)checkCameraAuthorizationGrand:(void(^)(void))permissonBlock noPermissonBlock:(void(^)(void))noPermissonBlock;

//麦克风权限
+(void)checkMicrophoneAuthorizationGrand:(void(^)(void))permissonBlock noPermissonBlock:(void(^)(void))noPermissonBlock;

//本地相册权限
+(void)checkPhotoAlbumAuthorizationGrand:(void(^)(void))permissonBlock noPermissonBlock:(void(^)(void))noPermissonBlock;

//j推送通知权限
+(void)checkoutNotificationAuthorizationGrand:(void(^)(BCNotiAuthGrandType authType))permissionBlock;

+(void)showSetAlertView:(NSString *)title message:(NSString *)message prefsURL:(NSString *)prefsURL;

@end
