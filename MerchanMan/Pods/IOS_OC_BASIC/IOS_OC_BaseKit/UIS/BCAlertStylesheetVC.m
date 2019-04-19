//
//  BCAlertStylesheetVC.m
//  BatteryCam
//
//  Created by yf on 2017/8/16.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCAlertStylesheetVC.h"
#import "BCStyleSheetCell.h"
#import "M1GuidanceView.h"
#import "YFCate.h"

static CGFloat rowH = 57;
static NSString *celliden = @"celliden";
@interface BCAlertStylesheetVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tv;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIView *contentView;
//@property (nonatomic,strong)UIVisualEffectView *ev;
@end

@implementation BCAlertStylesheetVC

-(void)setDatas:(id<BCStyleSheetListDelegate>)datas{
    _datas=datas;
    [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.datas.count*(dp2po(rowH))));
    }];
    [self.tv reloadData];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [super dismissViewControllerAnimated:NO completion:nil];
    if(self.dismissCB)
        self.dismissCB();
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.top.equalTo(self.view.mas_bottom);
    }];
    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
//        self.ev.alpha=0;
        self.view.backgroundColor=iColor(0, 0, 0, 0);
    } completion:^(BOOL finished) {
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(@0);
    }];
    
    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.ev.alpha=1;
        self.view.backgroundColor=iColor(0, 0, 0, .25);
        [self.view layoutIfNeeded];
    } completion:0];
}


#pragma mark - UITableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BCStyleSheetCell *cell = (BCStyleSheetCell*)[tableView dequeueReusableCellWithIdentifier:celliden];
    cell.mod=[self.datas get:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:nil];
    if([self.datas get:indexPath.row].cb)
        [self.datas get:indexPath.row].cb();
}

#pragma mark - UI

-(instancetype)init{
    if(self=[super init]){
        self.modalPresentationStyle=UIModalPresentationOverFullScreen;
        self.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=iColor(0, 0, 0, 0);
    [self initUI];
}


-(void)initUI{
    self.contentView = [[UIView alloc] init];
    [self.view addSubview:self.contentView];
    
    
    self.cancelBtn=[IProUtil commonTextBtn:iFont(dp2po(20)) color:iGlobalFocusColor title:NSLocalizedString(@"bc.common.cancel", 0)];
    [self.cancelBtn setTitleColor:iColor(0xaa, 0xaa, 0xaa, 1) forState:UIControlStateHighlighted];
    [self.cancelBtn setBackgroundColor:[UIColor whiteColor]] ;
    self.cancelBtn.layer.cornerRadius=12;
    [self.contentView addSubview:self.cancelBtn];
    [self.cancelBtn setBackgroundImage:[UIImage img4Color:iGlobalBG] forState:UIControlStateHighlighted];
    self.cancelBtn.clipsToBounds=YES;
    [self.cancelBtn addTarget:self action:@selector(dismissViewControllerAnimated:completion:) forControlEvents:UIControlEventTouchUpInside];
   
    self.tv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tv.separatorColor=iColor(0xdd, 0xdd, 0xdd, 1);
    self.tv.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tv.layer.cornerRadius=12;
    self.tv.delegate=self;self.tv.dataSource=self;
    [self.tv registerClass:BCStyleSheetCell.class forCellReuseIdentifier:celliden];
    self.tv.rowHeight=dp2po(rowH);
    [self.tv setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.tv.bounces=NO;
    [self.contentView addSubview:self.tv];
    [self setupLayout];
}


-(void)setupLayout{
//    self.ev = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//    [self.view insertSubview:self.ev atIndex:0];
//    self.ev.alpha=0;
//    [self.ev mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
//    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.top.equalTo(self.view.mas_bottom);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.trailing.equalTo(@-10);
        make.leading.equalTo(@10);
        make.height.equalTo(@(dp2po(rowH)));
    }];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@10);
        make.trailing.equalTo(@-10);
        make.bottom.equalTo(self.cancelBtn.mas_top).offset(-10);
        make.top.equalTo(@0);
        make.height.equalTo(@(self.datas.count*dp2po(rowH)));
    }];
    
}



#pragma mark - ratation
-(BOOL)shouldAutorotate {
    return self.presentingViewController.shouldAutorotate;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.presentingViewController.supportedInterfaceOrientations;
    
}


@end
