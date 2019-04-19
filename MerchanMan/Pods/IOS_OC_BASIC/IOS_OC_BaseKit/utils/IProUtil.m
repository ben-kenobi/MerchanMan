//
//  iProUtil.m
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "IProUtil.h"
#import "objc/runtime.h"

@interface BCDisableNoShadowBtn:UIButton
@end



@implementation IProUtil

+(UILabel *)commonLab:(UIFont *)font color:(UIColor *)color{
    UILabel *lab = [[UILabel alloc]init];
    lab.font=font;
    lab.textColor = color;
    lab.textAlignment=NSTextAlignmentLeft;
    lab.lineBreakMode=NSLineBreakByTruncatingTail;
//    lab.text=@"11-22 18:56:43";
    return lab;
}
+(UILabel *)commonLab:(UIFont *)font color:(UIColor *)color bg:(UIColor *)bg{
    UILabel *lab = [[UILabel alloc]init];
    lab.font=font;
    lab.textColor = color;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.lineBreakMode=NSLineBreakByTruncatingTail;
//    lab.text=@"11-22 18:56:43";
    lab.backgroundColor=bg;
    return lab;
}

+(UIButton *)commonTextBtn:(UIFont *)font color:(UIColor *)color title:(NSString *)title{
    UIButton *btn = [[BCDisableNoShadowBtn alloc] init];
    [btn setTitle:title forState:0];
    btn.titleLabel.font=font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:[color colorWithAlphaComponent:.6] forState:UIControlStateHighlighted];
    return btn;
}

+(UIButton *)commonNoShadowTextBtn:(UIFont *)font color:(UIColor *)color title:(NSString *)title{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:0];
    btn.titleLabel.font=font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:[color colorWithAlphaComponent:.6] forState:UIControlStateHighlighted];
    [btn setTitleColor:[color colorWithAlphaComponent:.3] forState:UIControlStateDisabled];
    return btn;
}




+(NSString *)durationFormat:(NSInteger)sec{
    NSString *str = iFormatStr(@"%02u:%02u",((uint32_t)sec/60)%60,(uint32_t)sec%60);
    if(sec>=60*60)
        str = iFormatStr(@"%02u:%@",(uint32_t)sec/60/60,str);
    return str;
}


+(UIButton *)btnWith:(CGRect)frame title:(NSString *)title bgc:(UIColor *)bgc font:(UIFont *)font sup:(UIView *)sup{
    UIButton *b=[[UIButton alloc] initWithFrame:frame];
    [b setBackgroundColor:bgc];
    [b setTitleColor:[UIColor whiteColor] forState:0];
    [b setTitleColor:[UIColor lightGrayColor] forState:1];
    b.layer.cornerRadius=3;
    //    self.myorder.layer.masksToBounds=YES;
    [b.layer setShadowOpacity:.3];
    [b.layer setShadowOffset:(CGSize){1 ,1}];
    [b.layer setShadowColor:[[UIColor lightGrayColor]CGColor]];
    [b.layer setShadowRadius:1];
    [sup addSubview:b];
    [b setTitle:title forState:0];
    b.titleLabel.font=font;
    return b;
}
+(UILabel*)labWithColor:(UIColor*)color font:(UIFont *)font sup:(UIView *)sup{
    UILabel *lab = [[UILabel alloc] init];
    lab.font=font;
    lab.textColor=color;
    lab.lineBreakMode=NSLineBreakByTruncatingTail;
    [sup addSubview:lab];
    return lab;
}



+(NSRegularExpression *)usernameRe{
    static NSRegularExpression * re;
    long l=0;
    dispatch_once(&l, ^{
        re=[NSRegularExpression regularExpressionWithPattern:@"(^[_a-zA-Z0-9.%+-]+@([_a-z A-Z 0-9]+\\.)+[a-z A-Z 0-9]{2,6}$)|(^0{0,1}(13[0-9]|15[7-9]|153|156|18[0-9])[0-9]{8}$)" options:0 error:0];
    });
        
    return re;
}
+(NSRegularExpression *)mobileRe{
    static NSRegularExpression * re;
    long l=0;
    dispatch_once(&l, ^{
        re=[NSRegularExpression regularExpressionWithPattern:@"(^0{0,1}(13[0-9]|15[7-9]|153|156|18[0-9])[0-9]{8}$)" options:0 error:0];
    });
    
    return re;
}

+(NSRegularExpression *)pwdRe{
    static NSRegularExpression * re;
    long l=0;
    dispatch_once(&l, ^{
        re=[NSRegularExpression regularExpressionWithPattern:@"^[a-z A-Z  0-9]{6,12}$" options:0 error:0];
    });
    return re;
}






+(BOOL)isEmail:(NSString *)str{
    if(emptyStr(str))return NO;
    static NSString * emailRegex = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$";
    static NSPredicate *pred=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    });
    return [pred evaluateWithObject:str];
}

+(BOOL)isLoginPwd:(NSString*)str{
//    if(!str||str.length<8||str.length>20) return NO;
//    return YES;
    static NSPredicate *pred=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString * pwdRegex = @"^.+$";
        pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pwdRegex];
    });
    return [pred evaluateWithObject:str];
}
+(BOOL)isSignupPwd:(NSString*)str{
    //    static NSString * emailRegex = @"^[\\x21-\\x7E]{8,20}$";
    //    static NSPredicate *pred=nil;
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    //    });
    //    return [pred evaluateWithObject:str];
    
    if(!str||str.length<8||str.length>20) return NO;
    NSPredicate *pred=nil;
    //    NSString *REGEX_PASSWORD_LENGTH = @"^[\\x21-\\x7E]{8,20}+$";
    //    NSString *REGEX_PASSWORD_LENGTH = @"^[0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~!@#$%^&*()_-=+\\|[{]}/?.>,\'\";:]{8,20}$";
    NSString *REGEX_PASSWORD_LENGTH =@"^[a-zA-Z0-9`~!@#%&()_=/>,\'\";:\\|\\\\\\^\\$\\*\\+\\?\\.\\{\\}\\-\\[\\]]{8,20}$";
    pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",REGEX_PASSWORD_LENGTH];
    return [pred evaluateWithObject:str];
    
    
    /*
     if(!str||str.length<8||str.length>20) return NO;
     
     NSPredicate *pred=nil;
     
     NSString *REGEX_PASSWORD_LENGTH = @"^.{8,20}$";
     
     NSString *REGEX_PASSWORD_NUM = @"^.*[0-9]+.*$";
     
     NSString *REGEX_PASSWORD_LETTER = @"^.*[A-Za-z]+.*$";
     
     //    NSString *REGEX_PASSWORD_SPE_CHARACTERS = @"^.*[~'!@#￥$%^&*()-+_=:/{/}/[/]/./?]+.*$";
     
     pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@  AND SELF MATCHES %@ AND SELF MATCHES %@",REGEX_PASSWORD_LENGTH,REGEX_PASSWORD_NUM,REGEX_PASSWORD_LETTER];
     
     //    pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@  AND SELF MATCHES %@ AND SELF MATCHES %@ AND SELF MATCHES %@",REGEX_PASSWORD_LENGTH,REGEX_PASSWORD_NUM,REGEX_PASSWORD_LETTER,REGEX_PASSWORD_SPE_CHARACTERS];
     return [pred evaluateWithObject:str];
     */
}



+(NSDictionary *)attrDictWith:(UIColor *)fcolor font:(UIFont *)font{
    return @{NSForegroundColorAttributeName:fcolor,NSFontAttributeName:font};
}



+(void)dispatchAfter:(CGFloat)secs tar:(id)tar bloc:(void(^)(void))bloc{
    [self dispatchAfter:secs tar:tar iden:@"tcommonblockkey" bloc:bloc];
}
+(void)dispatchCancel:(id)tar{
    [self dispatchCancel:tar iden:@"tcommonblockkey"];
}

+(void)dispatchAfter:(CGFloat)secs tar:(id)tar iden:(NSString *)iden bloc:(void(^)(void))bloc{
    if(secs<0)return;
    [self dispatchCancel:tar];
    __weak id wt = tar;
    dispatch_block_t block = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, ^{
        objc_setAssociatedObject(wt, iden.UTF8String, nil, OBJC_ASSOCIATION_ASSIGN);
        bloc();
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(secs * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
    objc_setAssociatedObject(tar, iden.UTF8String, block, OBJC_ASSOCIATION_ASSIGN);
}
+(void)dispatchCancel:(id)tar iden:(NSString *)iden{
    dispatch_block_t block = objc_getAssociatedObject(tar, iden.UTF8String);
    if(block){
        dispatch_block_cancel(block);
        objc_setAssociatedObject(tar,iden.UTF8String, nil, OBJC_ASSOCIATION_ASSIGN);
    };
}

+(void)addClickActiononTar:(UIControl *)tar withBlock:(void (^)(UIControl *tar))block{
    objc_setAssociatedObject(tar, "blockClickActionKey", block, OBJC_ASSOCIATION_COPY);
    [tar addTarget:self action:@selector(blockActionCB:) forControlEvents:UIControlEventTouchUpInside];
}
+(void)blockActionCB:(UIControl *)sender{
    void (^blo)(UIControl *tar) = objc_getAssociatedObject(sender, "blockClickActionKey");
    if(blo)
        blo(sender);
}

@end

@implementation BCDisableNoShadowBtn
-(void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    self.layer.shadowOpacity=enabled?.12:0;
}
@end


