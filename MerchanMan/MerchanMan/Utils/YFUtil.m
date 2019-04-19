//
//  YFUtil.m
//  BatteryCam
//
//  Created by yf on 2018/8/8.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "YFUtil.h"
#import "SVProgressHUD.h"
#import <AssetsLibrary/AssetsLibrary.h>



@implementation iPop
+(void)showMsg:(NSString*)msg{
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD showInfoWithStatus:msg];
}
+(void)showSuc:(NSString*)msg{
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD showSuccessWithStatus:msg];
}
+(void)showError:(NSString*)msg{
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD showErrorWithStatus:msg];
}
+(void)showProgWithMsg:(NSString *)msg{
    [SVProgressHUD setBackgroundLayerColor:iColor(0, 0, 0, .6)];
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeCustom)];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD  showWithStatus:msg];
}
+(void)showProg{
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeClear)];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD  show];
}
+(void)dismProg{
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeClear)];
    [SVProgressHUD dismiss];
}
+(void)toastWarn:(NSString*)msg{
    if(!msg)return;
    [UIUtil toastAt:[UIViewController topVC].view msg:msg color:iWarnTipColor icon:img(@"warning_icon")];
    
    //    runOnMain(^{
    //        //        iApp.windows[iApp.windows.count-1].makeToast(msg)
    //       /* [frontestWindow() makeToast:msg duration:1.5 position:nil title:nil image:nil style:[CSToastManager sharedStyle] completion:nil];*/
    //    });
}
+(void)toastSuc:(NSString *)msg{
    if(!msg)return;
    [UIUtil toastAt:[UIViewController topVC].view msg:msg color:iSucTipColor icon:[img(@"voice_con") renderWithColor:iSucTipColor]];
}
+(void)toastInfo:(NSString *)msg{
    if(!msg)return;
    [UIUtil toastAt:[UIViewController topVC].view msg:msg color:iInfoTipColor icon:[img(@"voice_con") renderWithColor:iInfoTipColor]];
}

+(void)bannerWarn:(NSString*)msg{
    [self bannerWarn:msg iden:@"show_msg"];
}
+(void)bannerSuc:(NSString *)msg{
    [self bannerSuc:msg iden:@"show_msg"];
}
+(void)bannerInfo:(NSString *)msg{
    [self bannerInfo:msg iden:@"show_msg"];
}

+(void)bannerWarn:(NSString*)msg iden:(NSString *)iden{
    if(!msg)return;
    [UIUtil showMsgAt:[UIViewController topVC].view msg:msg color:iInfoTipColor icon:img(@"voice_con")  iden:iden];
}
+(void)bannerSuc:(NSString *)msg iden:(NSString *)iden{
    if(!msg)return;
    [UIUtil showMsgAt:[UIViewController topVC].view msg:msg color:iInfoTipColor icon:[img(@"voice_con") renderWithColor:iSucTipColor]  iden:iden];
}
+(void)bannerInfo:(NSString *)msg iden:(NSString *)iden{
    if(!msg)return;
    [UIUtil showMsgAt:[UIViewController topVC].view msg:msg color:iInfoTipColor icon:[img(@"voice_con") renderWithColor:iInfoTipColor]  iden:iden];
}
@end

@implementation ALUtil:NSObject
+(void)setImgFromALURL:(NSURL*)alurl cb:(void(^)(UIImage *))cb{
    ALAssetsLibraryAssetForURLResultBlock resultblock=^(ALAsset *asset){
        ALAssetRepresentation* rep = asset.defaultRepresentation;
        __unsafe_unretained CGImageRef iref =  [rep fullResolutionImage];
        UIImage * image = [UIImage imageWithCGImage:iref];
        dispatch_async(dispatch_get_main_queue(), ^{
            cb(image);
        });
    };
    ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *error){
        printf("\n-----load ALAssets fail------\n");
    };
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:alurl resultBlock:resultblock failureBlock:failureblock];
}
@end
