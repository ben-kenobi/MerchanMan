

//
//  BCManualEnterSNVC.m
//  BatteryCam
//
//  Created by yf on 2018/11/15.
//  Copyright © 2018 oceanwing. All rights reserved.
//

#import "BCManualEnterSNVC.h"
#import "BCCustTf.h"
@interface BCManualEnterSNVC ()
@property(nonatomic,strong)BCCustTf *tf;
@property (nonatomic,strong)UIButton *btn;
@end

@implementation BCManualEnterSNVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    //TODO QRCODE
//        self.tf.text=@"T8001H0218180031";//老罗
//        self.tf.text=@"T8001H0218260038";//老高
//    self.tf.text=@"T8001H0218180042";//老高美国
//    self.tf.text=@"t8001H0218260030";//dino

}


#pragma mark - actions
-(void)next{
    if(!self.validate)return;
    [self.view endEditing:YES];
    if(self.resultCB)
        self.resultCB(self.tf.text);
}
-(BOOL)validate{
    //T8001H0218180030
    BOOL b = self.tf.text.length>=1;
    self.btn.enabled=b;
    return b;
}

#pragma mark - UI
-(void)initUI{
    self.title=@"手动输入";
    
    
    BCCustTf * (^createTf)(void)= ^BCCustTf * {
        BCCustTf *tf = [[BCCustTf alloc]init];
        tf.leftPad=dp2po(15);
        tf.rightPad=tf.leftPad;
        tf.bottomLine.hidden=YES;
        tf.adjustFocusColor=NO;
        tf.tintColor=iColor(0x20, 0x6b, 0xff, 1);
        tf.backgroundColor=[UIColor whiteColor];
        tf.font=iFont(17);
        tf.textColor=iColor(0x33, 0x33, 0x33, 1);
        //        [UIUtil commonShadowWithRadius:12 size:CGSizeMake(0, 4) view:tf opacity:.06];
        tf.layer.borderColor=iCommonSeparatorColor.CGColor;
        tf.layer.borderWidth=1;
        return tf;
    };
    __weak typeof(self)ws = self;
    self.tf=createTf();
    self.tf.placeholder=@"";
    [self.tf setOnTextChange:^(BCCustTf *tf) {
        [ws validate];
    }];
    [self.tf setOnReturn:^(BCCustTf *tf) {
        [ws next];
    }];
    self.tf.keyboardType=UIKeyboardTypeASCIICapable;
    
    
    UIImageView *iv = [[UIImageView alloc]initWithImage:img(@"")];
    UILabel *lab = [IProUtil commonLab:iFont(dp2po(14)) color:iColor(0x66, 0x66, 0x66, 1)];
    lab.numberOfLines=0;
    lab.text=@"手动输入条码内容";
    
    UIButton *btn = [IProUtil commonTextBtn:iFont(dp2po(17)) color:[UIColor whiteColor] title:@"OK"];
    [UIUtil commonTexBtn:btn tar:self action:@selector(next)];
    btn.enabled=NO;
    self.btn=btn;
    //layout -------------
    [self.view addSubview:iv];
    [self.view addSubview:lab];
    [self.view addSubview:btn];
    [self.view addSubview:_tf];
    
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(dp2po(30)));
        make.centerX.equalTo(@0);
    }];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iv.mas_bottom).offset(dp2po(37));
        make.leading.equalTo(@(dp2po(20)));
        make.trailing.equalTo(@(dp2po(-10)));
    }];
    [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lab);
        make.height.equalTo(@(dp2po(48)));
        make.trailing.equalTo(@(dp2po(-20)));
        make.top.equalTo(lab.mas_bottom).offset(dp2po(12));
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tf.mas_bottom).offset(dp2po(30));
        make.leading.width.height.equalTo(self.tf);
    }];
    
}

@end
