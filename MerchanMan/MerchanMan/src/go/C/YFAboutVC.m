//
//  BCAboutVC.m
//  BatteryCam
//
//  Created by yf on 2017/11/2.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "YFAboutVC.h"
#import "YFDisclaimerV.h"
#import "YFPrivacyVC.h"


@interface YFAboutVC ()
{
}
@property (nonatomic,strong)UILabel *versionLab;
@property (nonatomic,strong)YFDisclaimerV *disclaimer;
@property (nonatomic,strong)UILabel *titleLab;

@end

@implementation YFAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self updateData];
}
#pragma mark - actions
-(void)updateData{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.versionLab.text= iFormatStr(@"V%@_%ld", [IUtil appVersionStr],(long)[IUtil appVersion]);
    });
}

#pragma mark - actions
-(void)termNprivacy:(UIButton *)sender{
    YFPrivacyVC *vc = [[YFPrivacyVC alloc]init];
    [UIViewController pushVC:vc];
}

#pragma mark - UI
-(void)initUI{
    
    UIButton *iv = [[UIButton alloc]init];
    [iv setImage:img(@"icon_app") forState:0];
    
    self.titleLab=[IProUtil commonLab:iBFont(dp2po(20)) color:iColor(0x34, 0x35, 0x36, 1)];
    self.titleLab.lineBreakMode=NSLineBreakByTruncatingTail;
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    self.titleLab.text = @"商品管理";
    self.versionLab=[IProUtil commonLab:iFont(dp2po(16)) color:iColor(0xaa, 0xaa, 0xaa, 1)];
    
    NSString *contentStr = @"商品管理的使用许可和隐私条款";
    self.disclaimer=[[YFDisclaimerV alloc] initWithText:contentStr textAlignment:NSTextAlignmentCenter action:^(NSInteger protocolType) {
        [self termNprivacy:nil];
        [iAppDele.mainVC coverClick:YES];
    }];
    self.disclaimer.textAlignment=NSTextAlignmentCenter;
    
    UILabel *copyrightLab = [IProUtil commonLab:iFont(11) color:iColor(0x66, 0x66, 0x66, 1)];
    copyrightLab.text=@"Copyright © 2019 杨峰";

    
    //layout ----
    [self.view addSubview:iv];
    [self.view addSubview:self.versionLab];
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.disclaimer];
    [self.view addSubview:copyrightLab];
    
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.view.mas_centerY).multipliedBy(.48);
    }];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(iv.mas_bottom).offset(12);
    }];
    [self.versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.titleLab.mas_bottom).offset(dp2po(12));
    }];
    
    [copyrightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottomMargin).offset(-dp2po(25));
        make.centerX.equalTo(@0);
    }];
    [self.disclaimer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(copyrightLab.mas_top).offset(dp2po(-15));
        make.centerX.equalTo(@0);
        make.width.lessThanOrEqualTo(@(iScreenW-40));
    }];
}


@end
