
//
//  YFMerchanUtil.m
//  MerchanMan
//
//  Created by yf on 2019/4/22.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchanUtil.h"
#import "BCQRCodeAddVC.h"
#import "BCPermission.h"

@implementation YFMerchanUtil

+(void)gotoAppSetting{
    NSURL * url = iURL(UIApplicationOpenSettingsURLString);
    if([iApp canOpenURL:url]) {
        [iApp openURL:url options:@{} completionHandler:0];
    }
}


+(void)gotoScan:(void (^)(NSString *result))cb{
    [BCPermission checkCameraAuthorizationGrand:^{
        BCQRCodeAddVC *vc = [[BCQRCodeAddVC alloc]init];
        vc.onScanResult = cb;
        [UIViewController pushVC:vc];
    } noPermissonBlock:^{
        
    }];
}


+(void)gotoAlbum:(id)delegate edit:(BOOL)edit{
    [BCPermission checkPhotoAlbumAuthorizationGrand:^{
        UIImagePickerController *vc = [[UIImagePickerController alloc]init];
        vc.delegate=delegate;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;  //苹果推荐使用全屏
        vc.allowsEditing = edit;
        vc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [UIViewController.topVC presentViewController:vc animated:YES completion:nil];
    } noPermissonBlock:^{
        
    }];
}
+(void)gotoCamera:(id)delegate edit:(BOOL)edit{
    [BCPermission checkCameraAuthorizationGrand:^{
        UIImagePickerController *vc = [[UIImagePickerController alloc]init];
        vc.delegate=delegate;
        vc.allowsEditing = edit;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;  //苹果推荐使用全屏
        
        vc.sourceType=UIImagePickerControllerSourceTypeCamera;
        [UIViewController.topVC presentViewController:vc animated:YES completion:nil];
    } noPermissonBlock:^{
        
    }];
}

@end
