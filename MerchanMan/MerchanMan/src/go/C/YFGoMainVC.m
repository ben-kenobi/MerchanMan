
//
//  YFGoMainVC.m
//  BetaGo
//
//  Created by yf on 2019/3/7.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFGoMainVC.h"
#import "YFChessBoradView.h"
#import "YFMatch.h"
@interface YFGoMainVC ()
@property (nonatomic,strong)YFChessBoradView *board;
@property (nonatomic,strong)YFMatch *match;
@property (nonatomic,strong)UIButton *doneBtn;
@end

@implementation YFGoMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}



#pragma mark - UI
-(void)initUI{
    self.title = @"GO";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:img(@"sensitivity_icon") style:(UIBarButtonItemStylePlain) target:self action:@selector(onMenuClicked)];
    
    
    //init
    self.match = [[YFMatch alloc]initMatchWith:13];
    self.board = [[YFChessBoradView alloc]initWith:self.match];
    self.doneBtn = [IProUtil commonTextBtn:iFont(18) color:iGlobalFocusColor title:@"Done"];
    [self.doneBtn addTarget:self.board action:@selector(confirmAddChess) forControlEvents:UIControlEventTouchUpInside];
    
    //layout --
    [self.view addSubview:self.board];
    [self.view addSubview:self.doneBtn];
    [self.board mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.leading.trailing.equalTo(@0);
        make.width.equalTo(self.board.mas_height);
    }];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.board.mas_bottom).offset(dp2po(25));
        make.centerX.equalTo(@0);
    }];
    
}
#pragma mark - UIBarButtonItem Event
-(void)onMenuClicked{
    [[iAppDele mainVC] leftClick:YES];
}
@end
