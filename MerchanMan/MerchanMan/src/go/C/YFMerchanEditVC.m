


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


@interface YFMerchanEditVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIButton *imgBtn;
@property (nonatomic,strong)BCCustTf *nametf;
@property (nonatomic,strong)BCCustTf *inPricetf;
@property (nonatomic,strong)BCCustTf *outPricetf;
@property (nonatomic,strong)UILabel *codeLab;
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
-(void)checkData{
    self.navigationItem.rightBarButtonItem.enabled = !emptyStr(self.nametf.text);
}

#pragma mark - actions
-(void)save:(id)sender{
    [self.view endEditing:YES];
}

-(void)onAddImg{
    
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
    
    
    self.sv  = [[UIScrollView alloc]init];
    self.sv.showsVerticalScrollIndicator = NO;
    self.sv.showsHorizontalScrollIndicator = NO;
    self.sv.delegate = self;
    self.sv.bounces = YES;
    
    self.contentView = [[UIView alloc]init];
    
 
    
    
    // main layout --
    [self.view addSubview:self.sv];
    [self.sv addSubview:self.contentView];
    
    
    [self.sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(12, 12, 15, 12)]);
        make.width.equalTo(self.sv).offset(-24);
    }];
    
    
    
    
    //subviews
    
    self.imgBtn = [[UIButton alloc]init];
    [self.imgBtn setBackgroundImage:img(@"img_add_icon") forState:0];
    [self.imgBtn addTarget:self action:@selector(onAddImg) forControlEvents:UIControlEventTouchUpInside];
    
    self.nametf = [self commonTf];
    UIView *nameV = [self titleLab:@"名称：" NContentView:self.nametf];
    self.inPricetf = [self commonTf];
    self.inPricetf.keyboardType = UIKeyboardTypeDecimalPad;
    UIView *inPriceV = [self titleLab:@"进价：" NContentView:self.inPricetf];
    self.outPricetf = [self commonTf];
    self.outPricetf.keyboardType = UIKeyboardTypeDecimalPad;
    UIView *outPriceV = [self titleLab:@"出价：" NContentView:self.outPricetf];
    
    
    //subviews layout ---
    
    [self.contentView addSubview:self.imgBtn];
    [self.contentView addSubview:nameV];
    [self.contentView addSubview:inPriceV];
    [self.contentView addSubview:outPriceV];

    [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(@0);
        make.width.height.equalTo(@128);
    }];
    [nameV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.top.equalTo(self.imgBtn.mas_bottom).offset(12);
        make.height.equalTo(@55);
        make.trailing.equalTo(@0);
    }];
    
    [inPriceV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imgBtn.mas_trailing).offset(10);
        make.trailing.equalTo(@0);
        make.height.equalTo(nameV);
        make.top.equalTo(self.imgBtn).offset(8);
    }];
    [outPriceV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.equalTo(inPriceV);
        make.top.equalTo(inPriceV.mas_bottom);
    }];
}



-(UIView *)titleLab:(NSString *)title NContentView:(UIView *)contentView{
    UIView *container = [[UIView alloc]init];
    UILabel *lab = [IProUtil commonLab:iFont(17) color:iColor(0x66, 0x66, 0x66, 1)];
    lab.text = title;
    [container addSubview:lab];
    [container addSubview:contentView];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lab.mas_trailing).offset(8);
        make.centerY.equalTo(@0);
        make.trailing.equalTo(@0);
        make.height.equalTo(container.mas_height).multipliedBy(.8);
    }];
    return container;
    
}

-(BCCustTf *)commonTf{
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
    BCCustTf *tf = createTf();
    tf.placeholder=@"";
    [tf setOnTextChange:^(BCCustTf *tf) {
        [se checkData];
    }];
    [tf setOnReturn:^(BCCustTf *tf) {
    }];
    return tf;
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
