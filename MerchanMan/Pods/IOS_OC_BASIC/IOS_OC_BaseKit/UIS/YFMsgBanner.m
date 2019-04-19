
//
//  YFMsgBanner.m
//  BatteryCam
//
//  Created by yf on 2018/2/28.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "YFMsgBanner.h"
#import "YFCate.h"


@interface YFMsgBanner()

@property (nonatomic,strong)UILabel *msgLab;
@property (nonatomic,assign)NSInteger countdown;
@property (nonatomic,strong)NSString *iden;
@property (nonatomic,strong)UIButton *disBtn;
@property (nonatomic,strong)UIImageView *speakIcon;
@property (nonatomic,assign)BOOL fullScreen;
@property (nonatomic,strong)UIImage *disImg;
@end

@implementation YFMsgBanner

/**
 

 @param view 需要在其上显示的视图
 @param sec 自动消失的时间，小于0则不消失，-1则显示取消按钮
 @param msg 显示的消息
 @param iden 作为全局标志的banner id
 @param textcolor 文字颜色
 @param icon 消息图标
 @return return value description
 */
+(instancetype)showAt:(UIView*)view withCountdown:(NSInteger)sec msg:(NSString *)msg iden:(NSString *)iden color:(UIColor *)textcolor icon:(UIImage *)icon{
    return [self showAt:view withCountdown:sec msg:msg iden:iden color:textcolor icon:icon fullScreen:NO];
}
+(instancetype)showAt:(UIView*)view withCountdown:(NSInteger)sec msg:(NSString *)msg iden:(NSString *)iden color:(UIColor *)textcolor icon:(UIImage *)icon fullScreen:(BOOL)fullScreen{
    if(!view) return nil;
    YFMsgBanner *banner = [msgBanners() objectForKey:iden];
    if(!banner)
        banner = [[YFMsgBanner alloc]init];
    banner.countdown=sec;
    banner.msgLab.text=msg;
    banner.disBtn.hidden=sec!=-1;
    banner.fullScreen=fullScreen;
    [banner.speakIcon setImage:icon];
    if(textcolor){
        banner.msgLab.textColor=textcolor;
    }
    banner.iden=iden;
    [banner showAt:view];
    return banner;
}

#pragma markk - show

-(void)showAt:(UIView *)view{
    [IProUtil dispatchCancel:self];
    if(self.superview!=view){
        [self removeFromSuperview];
        self.alpha=0;
        [view addSubview:self];
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(self.fullScreen?0: view.layoutMargins.top);
            make.leading.equalTo(@0);
            make.width.equalTo(view);
        }];
        [self.msgLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.speakIcon.mas_trailing).offset(dp2po(8));
            make.trailing.equalTo(self.disBtn.mas_leading);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.height.equalTo(@0);
        }];
        [_disBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@((self.fullScreen?iStBH*.5:0)));
            make.width.height.equalTo(self.disBtn.hidden?@0 : @(dp2po(30)));
            make.trailing.equalTo(@(-8));
        }];
        [self.speakIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@(dp2po(6)));
            make.bottom.equalTo(self.mas_top);
            make.height.width.equalTo(@18);
        }];
        [view layoutIfNeeded];
    }
    [msgBanners() setObject:self forKey:self.iden];

    [self.msgLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.speakIcon.mas_trailing).offset(dp2po(8));
        make.trailing.equalTo(self.disBtn.mas_leading);
        make.top.equalTo(@(12+(self.fullScreen?iStBH:0)));
        make.bottom.equalTo(@-12);
    }];
    
    [self.speakIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(dp2po(6)));
        UIImage *img =  self.speakIcon.image;
        make.centerY.equalTo(self.msgLab.mas_top).offset(img.h*.5);
        if(img){
            make.height.equalTo(@(img.h));
            make.width.equalTo(@(img.w));
        }else{
            make.height.width.equalTo(@0);
        }
    }];
   
    [UIUtil commonAnimation:^{
        [view layoutIfNeeded];
        self.alpha=1;
    }];
    @weakRef(self)
    [IProUtil dispatchAfter:self.countdown tar:self bloc:^{
        [weak_self dismiss];
    }];
}



#pragma markk - dismiss
+(void)dismiss:(NSString *)iden{
    YFMsgBanner *banner = [msgBanners() objectForKey:iden];
    [banner dismiss];
}

-(void)removeFromSuperview{
    [super removeFromSuperview];
    [IProUtil dispatchCancel:self];
    [msgBanners() removeObjectForKey:self.iden];
}

-(void)dismiss{
    [IProUtil dispatchCancel:self];
    if(!self.superview)return;
    [self.msgLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.speakIcon.mas_trailing).offset(dp2po(8));
        make.trailing.equalTo(self.disBtn.mas_leading);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@0);
    }];
    [self.speakIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(dp2po(6)));
        make.bottom.equalTo(self.mas_top);
        make.height.width.equalTo(@18);
    }];
    @weakRef(self)
    [UIUtil commonAnimationWithDuration:.25 cb:^{
        [weak_self.superview layoutIfNeeded];
        weak_self.alpha=0;
    } comp:^(BOOL finish) {
        [weak_self removeFromSuperview];
    }];
}



#pragma mark - UI
-(instancetype)init{
    if(self = [super init]){
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.clipsToBounds=NO;
    self.backgroundColor=iTipBGColor;
    
    self.msgLab=[IProUtil commonLab:iFont(14) color:iColor(0x5a, 0x55, 0x55, 1)];
    self.msgLab.numberOfLines=0;
    self.msgLab.textAlignment=NSTextAlignmentLeft;
    self.disBtn=[[UIButton alloc]init];
    NSString *closeImgResPath =[[NSBundle bundleForClass:self.class] pathForResource:scaledImgName(@"closed_con", @"png") ofType:0];
    UIImage *closeImg = imgFromF(closeImgResPath);
    self.disImg=closeImg;
    [self.disBtn setImage:self.disImg forState:0];
    [self.disBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.speakIcon=[[UIImageView alloc]init];
    self.speakIcon.contentMode=UIViewContentModeCenter;
    [UIUtil commonShadow:self opacity:.06];
    
    // layout ------
    [self addSubview:self.msgLab];
    [self addSubview:self.disBtn];
    [self addSubview:self.speakIcon];
}




           
           
NSMutableDictionary * msgBanners(){
    static NSMutableDictionary *mdict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mdict=[NSMutableDictionary dictionary];
    });
    return mdict;
}
@end
