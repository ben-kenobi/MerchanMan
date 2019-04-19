//
//  YFClearableTF.m
//  BatteryCam
//
//  Created by yf on 2017/8/18.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "YFClearableTF.h"
#import "YFCate.h"

@interface YFClearableTF()
@property (nonatomic,strong)UIButton *btn;
@end


@implementation YFClearableTF

-(void)onClear{
    self.text=@"";
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([@"enabled" isEqualToString:keyPath]){
        UIView *ph = [self valueForKey:@"_placeholderLabel"];
        ph.hidden=!self.enabled;
    }else if([@"text" isEqualToString:keyPath]){
        [self onTextChanged:nil];
    }
}
-(void)onTextChanged:(NSNotification *)noti{
    self.btn.hidden=emptyStr(self.text);
    if(self.onTxtChangeCB)
        self.onTxtChangeCB(self);
}

-(void)dealloc{
    [iNotiCenter removeObserver:self];
    [self removeObserver:self forKeyPath:@"enabled"];
    [self removeObserver:self forKeyPath:@"text"];
}

#pragma mark - UI
-(instancetype)init{
    if(self = [super init]){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    self.leftViewMode=UITextFieldViewModeAlways;
    self.rightViewMode=UITextFieldViewModeWhileEditing;
    UIView *rv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
    self.rightView=rv;
    
    self.btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
    [self.btn setTitle:@"X" forState:0];
    self.btn.titleLabel.font=iBFont(13);
    [self.btn setTitleColor:[UIColor whiteColor] forState:0];
    [self.btn setBackgroundImage:[UIImage img4Color:iColor(0x99, 0x99, 0x99, 1)] forState:0];
    [self.btn setBackgroundImage:[UIImage img4Color:iColor(0xaa, 0xaa, 0xaa, 1)] forState:UIControlStateHighlighted];
    self.btn.layer.cornerRadius=8;
    self.btn.clipsToBounds=YES;
    [self.btn addTarget:self action:@selector(onClear) forControlEvents:UIControlEventTouchUpInside];
    self.btn.hidden=YES;
    [rv addSubview:self.btn];
    
    [iNotiCenter addObserver:self selector:@selector(onTextChanged:) name:UITextFieldTextDidChangeNotification object:self];
    [self addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionOld context:nil];
    
}


@end
