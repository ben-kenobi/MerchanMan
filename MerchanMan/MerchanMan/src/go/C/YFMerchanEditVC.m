


//
//  YFMerchanEditVC.m
//  MerchanMan
//
//  Created by yf on 2019/4/22.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchanEditVC.h"
#import "BCCustTf.h"
#import "BCCustTextView.h"
#import "BCCountTextView.h"
#import "YFMerchan.h"


@interface YFMerchanEditVC ()
@property (nonatomic,strong)BCCustTf *nametf;
@property (nonatomic,strong)BCCustTf *inPricetf;
@property (nonatomic,strong)BCCustTf *outPricetf;

@property (nonatomic,strong)BCCountTextView *countTv;
@property (nonatomic,strong)UIScrollView *sv;
@property (nonatomic,strong)UIView *contentView;
@end

@implementation YFMerchanEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self updateUI];
    [iNotiCenter addObserver:self selector:@selector(onKeyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.nametf becomeFirstResponder];
}
#pragma mark - datas
-(void)updateUI{
    if(self.mod){
    //    self.nametf.text = self.match.title;
    //    self.countTv.textView.text=self.match.remark;
    }
}

#pragma mark - actions
-(void)save:(id)sender{
    [self.view endEditing:YES];
}
-(void)onKeyboardChange:(NSNotification *)noti{
    CGFloat dura=[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endframe=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat h = endframe.size.height;
    CGFloat y = endframe.origin.y;
    BOOL hide = y>=iScreenH;
    [self.sv mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(hide?0:-h));
    }];
    
    [UIView animateWithDuration:dura animations:^{
        [self.view layoutIfNeeded];
    }];
    if(self.countTv.textView.isFirstResponder){
        //        [self.tv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
    }
}

#pragma mark - UISCrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark - UI
-(void)initUI{
    self.title = @"编辑";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem.tintColor = iGlobalFocusColor;
    self.navigationItem.rightBarButtonItem.enabled=NO;
}


-(BCCustTf *)nametf{
    if(_nametf)return _nametf;
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
    __weak typeof (self)se=self;
    _nametf=createTf();
    _nametf.placeholder=@"";
    [_nametf setOnTextChange:^(BCCustTf *tf) {
        [se updateUI];
    }];
    [_nametf setOnReturn:^(BCCustTf *tf) {
    }];
    return _nametf;
}
-(BCCountTextView *)countTv{
    if(_countTv)return _countTv;
    // content Sv ---begin
    
    _countTv=[[BCCountTextView alloc]init];
    _countTv.maxCharacters = 600;
    _countTv.textView.placeholder = @"";
    return _countTv;
}

@end
