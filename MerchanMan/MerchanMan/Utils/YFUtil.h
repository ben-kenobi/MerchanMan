//
//  YFUtil.h
//  BatteryCam
//
//  Created by yf on 2018/8/8.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFUtil.h"


@interface iPop : NSObject

+(void)showMsg:(NSString*)msg;
+(void)showSuc:(NSString*)msg;
+(void)showError:(NSString*)msg;
+(void)showProgWithMsg:(NSString *)msg;
+(void)showProg;
+(void)dismProg;
+(void)toastSuc:(NSString*)msg;
+(void)toastInfo:(NSString*)msg;
+(void)toastWarn:(NSString*)msg;
+(void)bannerWarn:(NSString*)msg;
+(void)bannerSuc:(NSString *)msg;
+(void)bannerInfo:(NSString *)msg;
+(void)bannerWarn:(NSString*)msg iden:(NSString *)iden;
+(void)bannerSuc:(NSString *)msg iden:(NSString *)iden;
+(void)bannerInfo:(NSString *)msg iden:(NSString *)iden;
@end

@interface ALUtil:NSObject
+(void)setImgFromALURL:(NSURL*)alurl cb:(void(^)(UIImage *))cb;
@end
