//
//  iProUtil.h
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFCate.h"

@interface IProUtil : NSObject



+(UIButton *)btnWith:(CGRect)frame title:(NSString *)title bgc:(UIColor *)bgc font:(UIFont *)font sup:(UIView *)sup;
+(UILabel*)labWithColor:(UIColor*)color font:(UIFont *)font sup:(UIView *)sup;
+(NSRegularExpression *)usernameRe;
+(NSRegularExpression *)pwdRe;
+(NSRegularExpression *)mobileRe;

+(NSString *)durationFormat:(NSInteger)sec;

+(UILabel *)commonLab:(UIFont *)font color:(UIColor *)color;
+(UIButton *)commonTextBtn:(UIFont *)font color:(UIColor *)color title:(NSString *)title;
+(UIButton *)commonNoShadowTextBtn:(UIFont *)font color:(UIColor *)color title:(NSString *)title;
+(UILabel *)commonLab:(UIFont *)font color:(UIColor *)color bg:(UIColor *)bg;
+(BOOL)isEmail:(NSString *)str;
+(BOOL)isLoginPwd:(NSString*)str;
+(BOOL)isSignupPwd:(NSString*)str;

+(NSDictionary *)attrDictWith:(UIColor *)fcolor font:(UIFont *)font;
+(void)dispatchAfter:(CGFloat)secs tar:(id)tar bloc:(void(^)(void))bloc;
+(void)dispatchCancel:(id)tar;
+(void)dispatchAfter:(CGFloat)secs tar:(id)tar iden:(NSString *)iden bloc:(void(^)(void))bloc;
+(void)dispatchCancel:(id)tar iden:(NSString *)iden;
+(void)addClickActiononTar:(UIControl *)tar withBlock:(void (^)(UIControl *tar))block;
@end

