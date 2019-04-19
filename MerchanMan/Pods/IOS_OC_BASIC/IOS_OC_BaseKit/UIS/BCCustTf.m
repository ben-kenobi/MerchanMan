//
//  BCCustTf.m
//  BatteryCam
//
//  Created by yf on 2017/10/25.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCCustTf.h"
#import "YFCate.h"
static  NSInteger BC_MAX_TEXT_LEN=1000;
@interface BCCustTf()
@property (nonatomic,weak)id<UITextFieldDelegate> subDelegate;
@property (nonatomic,strong)UIButton *delBtn;
@property (nonatomic,strong)UIButton *showPwd;
@property (nonatomic,strong)UIButton *arrowBtn;
@property (nonatomic,assign)BOOL isPwd;

@end

@implementation BCCustTf
-(void)dealloc{
    [iNotiCenter removeObserver:self];
    [self removeObserver:self forKeyPath:@"text"];
}
#pragma mark - actions
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
   [self onContentChange_sup];
}


-(void)changeNoti:(NSNotification *)noti{
    [self updateTextContentByMaxLen];
    [self onContentChange_sup];
}
-(void)onContentChange_sup{
    [self updateDelBtn];
    if(self.onTextChange)
        self.onTextChange(self);
    [self onContentChange];
}
-(void)onContentChange{
    // subclass implementation
}

-(void)updateTextContentByMaxLen{
    NSString *text = self.text;
    NSData *data=[text dataUsingEncoding:4];
    if(self.maxLen<=0 || data.length<=self.maxLen)return;
    while(data.length>self.maxLen&&text.length>0){
        text=[text substringToIndex:text.length-1];
        data=[text dataUsingEncoding:4];
    }
    self.text=text;
}

-(void)onDel{
    self.text=@"";
}
-(void)onShowPwd{
    self.showPwd.selected=!self.showPwd.selected;
    [super setSecureTextEntry:!self.showPwd.selected];
}
-(void)onShowArrow{
    self.arrowBtn.selected=!self.arrowBtn.selected;
    if(self.onArrowClick)
        self.onArrowClick(self.arrowBtn, self);
}

#pragma mark - getter & setter
-(void)setLeftPad:(CGFloat)leftPad{
    _leftPad=leftPad;
    self.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, leftPad, 0)];
    self.leftViewMode=UITextFieldViewModeAlways;
}
-(void)setRightPad:(CGFloat)rightPad{
    _rightPad=rightPad;
    [self updateUI];
}
-(void)setShowArrow:(BOOL)showArrow{
    _showArrow=showArrow;
    [self updateUI];
}

-(UIView *)topline{
    if(!_topline){
        _topline=[[UIView alloc]init];
        [self addSubview:_topline];
        _topline.backgroundColor=iTfLineColoe;
        [_topline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(@0);
            make.height.equalTo(@(dp2po(1)));
        }];
    }
    return _topline;
}

-(void)setSecureTextEntry:(BOOL)secureTextEntry{
    [super setSecureTextEntry:secureTextEntry];
    self.isPwd=secureTextEntry;
}

-(void)setIsPwd:(BOOL)isPwd{
    _isPwd=isPwd;
    [self updateUI];
}


-(UIButton *)delBtn{
    if(!_delBtn){
        _delBtn=[[UIButton alloc] init];
        [_delBtn setImage:img(@"closed_icon") forState:UIControlStateNormal];
        [_delBtn addTarget:self action:@selector(onDel) forControlEvents:UIControlEventTouchUpInside];
        _delBtn.hidden=emptyStr(self.text);
        _delBtn.hidden=YES;
    }
    return _delBtn;
}
-(UIButton *)showPwd{
    if(!_showPwd){
        _showPwd=[UIButton btnWithImg:img(@"eye_close_icon") selImg:img(@"eye_open_icon")];
        _showPwd.selected=!self.isSecureTextEntry;
         [_showPwd addTarget:self action:@selector(onShowPwd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showPwd;
}

-(UIButton *)arrowBtn{
    if(!_arrowBtn){
        _arrowBtn=[UIButton btnWithImg:img(@"choose_down_con") selImg:img(@"choose_up_con")];
        [_arrowBtn addTarget:self action:@selector(onShowArrow) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowBtn;
}



#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //空的代表删除，返回允许
    if(self.maxLen<=0||emptyStr(string)){
        return YES;
    }
    if(textField.text.length+string.length>self.maxLen){
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(self.shouldBeginEditing)
        return self.shouldBeginEditing(self);
    if([self.subDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]){
        return [self.subDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}        // return NO to disallow editing.

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if([self.subDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]){
        [self.subDelegate textFieldDidBeginEditing:textField];
    }
    if(self.adjustFocusColor){
        self.bottomLine.backgroundColor=iGlobalFocusColor;
        _topline.backgroundColor=self.bottomLine.backgroundColor;
    }
    if(self.onEditingChange)
        self.onEditingChange(self);
    [self updateDelBtn];
}        // became first responder


- (void)textFieldDidEndEditing:(UITextField *)textField{
    if([self.subDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]){
        [self.subDelegate textFieldDidEndEditing:textField];
    }
    self.bottomLine.backgroundColor=iTfLineColoe;
    _topline.backgroundColor=self.bottomLine.backgroundColor;
    self.delBtn.hidden=YES;
    if(self.onEditingChange)
        self.onEditingChange(self);

}         // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    if([self.subDelegate respondsToSelector:@selector(textFieldDidEndEditing: reason:)]){
        [self.subDelegate textFieldDidEndEditing:textField reason:reason];
    }
    self.bottomLine.backgroundColor=iTfLineColoe;
    _topline.backgroundColor=self.bottomLine.backgroundColor;
    self.delBtn.hidden=YES;
    if(self.onEditingChange)
        self.onEditingChange(self);

}// if implemented, called in place of textFieldDidEndEditing:


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([self.subDelegate respondsToSelector:@selector(textFieldShouldReturn:)]){
        return [self.subDelegate textFieldShouldReturn:textField];
    }
    if(self.onReturn)
        self.onReturn(self);
    return NO;
}

#pragma mark - UI

-(void)updateUI{
    [self.rightView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.rightView addSubview:self.delBtn];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.equalTo(@0);
        make.width.equalTo(@(dp2po(38)));
    }];
    if(_isPwd){
        [self.rightView addSubview:self.showPwd];
        [self.showPwd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.width.equalTo(@(dp2po(35)));
            make.trailing.equalTo(@(-self->_rightPad));
        }];
    }else if(_showArrow){
        [self.rightView addSubview:self.arrowBtn];
        [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.width.equalTo(@(dp2po(35)));
            make.trailing.equalTo(@(-self->_rightPad));
        }];
    }
    self.rightViewMode = self.showArrow? UITextFieldViewModeAlways:UITextFieldViewModeWhileEditing;
    [self layoutIfNeeded];
}

-(instancetype)init{
    if(self = [super init]){
        [self initCommonUI];
        self.isPwd=NO;
        self.adjustFocusColor=YES;
    }
    return self;
}

-(void)initCommonUI{
    self.textColor=iColor(0x33, 0x33, 0x33, 1);
    self.font=iFont(dp2po(16));
    self.tintColor=iColor(0xbb, 0xbb, 0xbb, 1);
    self.tintColor=iGlobalFocusColor;
    
    self.bottomLine=[[UIView alloc]init];
    [self addSubview:self.bottomLine];
    self.bottomLine.backgroundColor=iTfLineColoe;
    self.delegate=self;
    UIView *rightv=[[UIView alloc]init];
    self.rightView=rightv;
    self.rightViewMode=UITextFieldViewModeWhileEditing;
    [self addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionOld) context:nil];
    [iNotiCenter addObserver:self selector:@selector(changeNoti:) name:UITextFieldTextDidChangeNotification object:nil];
    [self setupLayout];
}

-(void)setupLayout{
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(@0);
        make.height.equalTo(@(dp2po(1)));
    }];
}

-(CGRect)rightViewRectForBounds:(CGRect)bounds{
    CGFloat w = dp2po(38);
    w=(self.showLargRightView?w*2:w)+_rightPad;
    return CGRectMake(self.w-w, 0 ,w, self.h);
}

-(BOOL)showLargRightView{
    return self.isPwd||self.showArrow;
}

-(void)updateDelBtn{
    self.delBtn.hidden=emptyStr(self.text)||!self.isEditing;
}
-(UIReturnKeyType)returnKeyType{
    return UIReturnKeyDone;
}

@end
