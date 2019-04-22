//
//  BCQRCodeScanView.m
//  BatteryCam
//
//  Created by yf on 2018/11/15.
//  Copyright © 2018 oceanwing. All rights reserved.
//

#import "BCQRCodeScanView.h"
#import <AVFoundation/AVFoundation.h>

static const CGFloat kMargin=30;
static CGFloat scanh;
@interface BCQRCodeScanView ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong)AVCaptureSession *session;
@property (nonatomic,weak)AVCaptureVideoPreviewLayer *vlayer;
@property (nonatomic,weak)CAShapeLayer *coverLayer;
@end
@implementation BCQRCodeScanView

-(void)setRunning:(BOOL)running{
    _running=running;
    if(running)
        [self.session startRunning];
    else
        [self.session stopRunning];
}

-(BOOL)flashLight{
    BOOL b = NO;
    AVCaptureDevice *flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([flashLight isTorchAvailable] && [flashLight isTorchModeSupported:AVCaptureTorchModeOn])
    {
        BOOL success = [flashLight lockForConfiguration:nil];
        if (success)
        {
            if ([flashLight isTorchActive]) {
                b=NO;
                [flashLight setTorchMode:AVCaptureTorchModeOff];
            } else {
                b=YES;
                [flashLight setTorchMode:AVCaptureTorchModeOn];
            }
            [flashLight unlockForConfiguration];
        }
    }
    return b;
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if(metadataObjects.count>0){
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject *mobj=[metadataObjects objectAtIndex:0];
        if(self.scanResultCB)
            self.scanResultCB(mobj.stringValue);
    }
}

#pragma mark - UI
-(void)initUI{
    scanh=iScreenW*.8;

    //coverLayer------------
    CAShapeLayer *shapelayer= [CAShapeLayer layer];
    self.coverLayer=shapelayer;
    [self.coverLayer setFillColor:[iColor(0, 0, 0, .6) CGColor]];
    [self.coverLayer setFillRule:(kCAFillRuleEvenOdd)];
    [self.layer addSublayer:self.coverLayer];
    
    //scanView--------
    UIView *scanView=[[UIView alloc]init];
    scanView.clipsToBounds=YES;
    UIImageView *scanIv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"code_line"]];
    CABasicAnimation *ba=[CABasicAnimation animation];
    ba.keyPath=@"transform.translation.y";
    ba.byValue=@(scanh);
    ba.duration=1.2;
    ba.repeatCount=MAXFLOAT;
    ba.removedOnCompletion=NO;
    [scanIv.layer addAnimation:ba forKey:nil];
    
    
    UIImageView *tlIv=[[UIImageView alloc]initWithImage:[img(@"scan_1") renderWithColor:iColor(0x37, 0xaf, 0xaf, 1)]];
    UIImageView *trIv=[[UIImageView alloc]initWithImage:[img(@"scan_2") renderWithColor:iColor(0x37, 0xaf, 0xaf, 1)]];
    UIImageView *blIv=[[UIImageView alloc]initWithImage:[img(@"scan_3") renderWithColor:iColor(0x37, 0xaf, 0xaf, 1)]];
    UIImageView *brIv=[[UIImageView alloc]initWithImage:[img(@"scan_4") renderWithColor:iColor(0x37, 0xaf, 0xaf, 1)]];
    
    [self initPreview];
    
    //----------------layout-----
    [self addSubview:scanView];
    [scanView addSubview:scanIv];
    [self addSubview:tlIv];
    [self addSubview:trIv];
    [self addSubview:blIv];
    [self addSubview:brIv];
    
    
    [scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.equalTo(@(scanh));
    }];
    [scanIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.bottom.equalTo(scanView.mas_top);
        make.width.height.equalTo(scanView);
    }];
    [tlIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scanView).offset(-2);
        make.top.equalTo(scanView).offset(-2);
    }];
    [trIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(scanView).offset(2);
        make.top.equalTo(scanView).offset(-2);
    }];
    [blIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scanView).offset(-2);
        make.bottom.equalTo(scanView).offset(4);
    }];
    [brIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(scanView).offset(2);
        make.bottom.equalTo(scanView).offset(4);
    }];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.vlayer.frame=self.bounds;
    
    [self.coverLayer setBounds:self.bounds];
    [self.coverLayer setPosition:self.innerCenter];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, self.bounds);
    CGPathAddRect(path, nil, CGRectMake((self.w-scanh)*.5,(self.h-scanh)*.5 , scanh, scanh));
    [self.coverLayer setPath:path];
    CGPathRelease(path);
}

-(instancetype)init{
    if(self = [super init]){
        [self initUI];
        self.running=YES;
    }return self;
}

-(void)initPreview{
    AVCaptureDevice *dev=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *ip=[AVCaptureDeviceInput deviceInputWithDevice:dev error:nil];
    if(!ip) return ;
    
    AVCaptureMetadataOutput *op=[[AVCaptureMetadataOutput alloc] init];
    op.rectOfInterest=(CGRect){.15,.1,.7,.8};
    [op setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session=[[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetPhoto];
    [self.session addInput:ip];
    [self.session addOutput:op];
    op.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,
                             //条码
                             AVMetadataObjectTypeEAN13Code,
                             AVMetadataObjectTypeEAN8Code,
                             AVMetadataObjectTypeUPCECode,
                             AVMetadataObjectTypeCode39Code,
                             AVMetadataObjectTypeCode39Mod43Code,
                             AVMetadataObjectTypeCode93Code,
                             AVMetadataObjectTypeCode128Code,
                             AVMetadataObjectTypePDF417Code];
    //,
//                             AVMetadataObjectTypeEAN13Code,
//                             AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer=[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    [self.layer insertSublayer:layer atIndex:0];
    self.vlayer=layer;
    self.vlayer.frame=self.bounds;
}
-(void)dealloc{
    self.running=NO;
    self.session=nil;
}
@end
