
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

+(NSString *)fullImgPathByID:(NSString *)ID{
    return [iFormatStr(@"imgsDir/%@",ID) strByAppendToDocPath];
}
+(BOOL)saveImg:(UIImage *)img ID:(NSString *)ID{
    NSString *dir = [@"imgsDir/" strByAppendToDocPath];
    BOOL  exist = [iFm fileExistsAtPath:dir];
    if(!exist){
        [iFm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:0 error:0];
    }
    NSString *path = iFormatStr(@"%@%@",dir,ID);
    BOOL result = [UIImageJPEGRepresentation(img, .7) writeToFile:path atomically:YES];
    return result;
}
+(BOOL)rmImgs:(NSArray<NSString *> *)IDS{
    for(NSString *ID in IDS){
        [FileUtil rmFiles:@[[self fullImgPathByID:ID]]];
    }
    return YES;
}

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


+(void)photoChooser:(id)dele{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *camAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self gotoCamera:dele edit:YES];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self gotoAlbum:dele edit:YES];
    }];
    [vc addAction:camAction];
    [vc addAction:albumAction];
    [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [UIViewController.topVC presentViewController:vc animated:YES completion:0];
}
@end
