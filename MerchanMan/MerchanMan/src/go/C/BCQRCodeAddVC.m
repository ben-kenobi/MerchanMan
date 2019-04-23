//
//  BCQRCodeAddVC.m
//  BatteryCam
//
//  Created by yf on 2018/8/6.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "BCQRCodeAddVC.h"
#import "BCQRCodeScanView.h"
#import "BCTopIconBtn.h"
#import "BCManualEnterSNVC.h"
#import <AVFoundation/AVFoundation.h>

@interface  BCQRCodeAddVC ()
@property (nonatomic,strong)BCQRCodeScanView *canvas;
@property (nonatomic,strong)UIButton *flashBtn;
@property (nonatomic,strong)AVCaptureDevice *videoDevice;
@end

@implementation BCQRCodeAddVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.clipsToBounds=YES;
    [self initUI];
    self.videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    [self.videoDevice addObserver:self forKeyPath:@"torchActive" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"torchActive"]) {
        self.flashBtn.selected=self.videoDevice.torchActive;
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
-(void)dealloc{
    [self.videoDevice removeObserver:self forKeyPath:@"torchActive"];
}


#pragma mark - actions

-(void)manualInput{
    BCManualEnterSNVC *vc = [[BCManualEnterSNVC alloc]init];
    @weakRef(self)
    [vc setResultCB:^(NSString * _Nonnull sn) {
        [weak_self handleResult:sn scan:NO];
    }];
    [UIViewController pushVC:vc];
}
-(void)flashLight{
     [self.canvas flashLight];
}

-(void)handleResult:(NSString *)result scan:(BOOL)scan{
    if(self.onScanResult)
        self.onScanResult(result);
}

#pragma mark - UI
-(void)initUI{
    self.title=@"扫码";
    self.canvas=[[BCQRCodeScanView alloc]init];
    @weakRef(self)
    [self.canvas setScanResultCB:^(NSString * _Nonnull result) {
        [weak_self handleResult:result scan:YES];
    }];
    
    UIView *botv = [self newbottomView];
    
    
    
    
    //-----layout
    [self.view addSubview:self.canvas];
    [self.view addSubview:botv];
    [self.canvas mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.width.equalTo(self.view);
        make.bottom.equalTo(@(dp2po(-140)));
    }];
    [botv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(@0);
        make.top.equalTo(self.canvas.mas_bottom);
    }];
    
}

-(UIView *)newbottomView{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor=[UIColor whiteColor];
    
    
    BCTopIconBtn *(^createBtn)(NSString *title,NSString *seltitle,NSString *icon,NSString *seIcon,SEL sel)=^(NSString *title,NSString *seltitle,NSString *icon,NSString *seIcon,SEL sel){
        BCTopIconBtn *btn = [[BCTopIconBtn alloc]init];
        [btn setTitle:title forState:0];
        btn.titleLabel.font=iFont(dp2po(12));
        [btn setTitle:seltitle forState:UIControlStateSelected];
        [btn setImage:img(icon) forState:0];
        [btn setImage:img(seIcon) forState:UIControlStateSelected];
        [btn setTitleColor:iColor(0x33, 0x33, 0x33, 1) forState:0];
        [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
        return btn;
    };
    
    BCTopIconBtn *manualBtn = createBtn(@"手动输入",0,@"hand_s_icon",0,@selector(manualInput));
    BCTopIconBtn *flashlightBtn = createBtn(@"开闪光灯",@"关闪光灯",@"flashlight_off_t_icon",@"flashlight_on_n_icon",@selector(flashLight));
    self.flashBtn=flashlightBtn;
    
    //layout ---
    [view addSubview:manualBtn];
    [view addSubview:flashlightBtn];
    [manualBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(-(dp2po(80))));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(dp2po(150)));
        make.height.equalTo(@(100));
    }];
    [flashlightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@((dp2po(80))));
        make.centerY.width.height.equalTo(manualBtn);
    }];
    return view;
}




-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIUtil commonNav:self shadow:NO line:YES translucent:NO];
    self.canvas.running=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.canvas.running=NO;
}

@end
