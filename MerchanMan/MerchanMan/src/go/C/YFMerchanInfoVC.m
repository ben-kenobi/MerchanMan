

//
//  YFMerchanInfoVC.m
//  MerchanMan
//
//  Created by yf on 2019/4/22.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchanInfoVC.h"
#import "BCCustTf.h"
#import "BCCustTextView.h"
#import "BCCountTextView.h"
#import "YFMerchan.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "KSPhotoBrowser.h"

@interface YFMerchanInfoVC ()
@property (nonatomic,strong)UIButton *iconBtn;
@property (nonatomic,strong)UILabel *lab;
@end

@implementation YFMerchanInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self updateUI];
}
#pragma mark - datas
-(void)updateUI{
    [self.iconBtn sd_setImageWithURL:self.mod.defIconUrl forState:0];
    self.lab.attributedText = self.mod.fullAttrDesc;
}

#pragma mark - actions
-(void)onEdit{
    
}

-(void)iconClick{
    NSMutableArray *items = @[].mutableCopy;
    KSPhotoItem *item = [KSPhotoItem itemWithSourceView:self.iconBtn.imageView image:imgFromData(self.mod.defIconUrl.absoluteString)];
    [items addObject:item];
    
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:0];
    [browser showFromViewController:self];
}

#pragma mark - UI
-(void)initUI{
    self.title = @"详情";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:(UIBarButtonItemStylePlain) target:self action:@selector(onEdit)];
    self.navigationItem.rightBarButtonItem.tintColor = iGlobalFocusColor;
    self.navigationItem.rightBarButtonItem.enabled=YES;
    
    self.iconBtn = [[UIButton alloc]init];
    self.iconBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.iconBtn addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
    self.lab = [IProUtil commonLab:iFont(15) color:iColor(0x88, 0x88, 0x88, 1)];
    self.lab.numberOfLines = 0;
    
    [self.view addSubview:self.iconBtn];
    [self.view addSubview:self.lab];
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@5);
        make.width.lessThanOrEqualTo(self.view).multipliedBy(.92);
        make.height.lessThanOrEqualTo(self.view.mas_width).multipliedBy(.8);
    }];
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.trailing.lessThanOrEqualTo(@-8);
        make.top.equalTo(self.iconBtn.mas_bottom).offset(22);
    }];
}

@end
