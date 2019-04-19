//
//  YFMsgBanner.h
//  BatteryCam
//
//  Created by yf on 2018/2/28.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFMsgBanner : UIView
+(instancetype)showAt:(UIView*)view withCountdown:(NSInteger)sec msg:(NSString *)msg iden:(NSString *)iden color:(UIColor *)textcolor icon:(UIImage *)icon;
+(instancetype)showAt:(UIView*)view withCountdown:(NSInteger)sec msg:(NSString *)msg iden:(NSString *)iden color:(UIColor *)textcolor icon:(UIImage *)icon fullScreen:(BOOL)fullScreen;
+(void)dismiss:(NSString *)iden;
-(void)dismiss;
@end
