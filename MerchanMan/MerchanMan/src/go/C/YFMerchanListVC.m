
//
//  YFGoMainVC.m
//  BetaGo
//
//  Created by yf on 2019/3/7.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchanListVC.h"
@interface YFMerchanListVC ()

@end

@implementation YFMerchanListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

#pragma mark - actions
-(void)onAdd{
    
}
-(void)onScan{
    
}



#pragma mark - UI
-(void)initUI{
    self.title = @"商品列表";
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:img(@"sensitivity_icon") style:(UIBarButtonItemStylePlain) target:self action:@selector(onMenuClicked)];
    UIBarButtonItem *additem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(onAdd)];
    UIBarButtonItem *scanitem = [[UIBarButtonItem alloc]initWithImage:[img(@"scanicon") renderWithColor:iColor(0x44, 0x44, 0x44, 1)] style:UIBarButtonItemStylePlain target:self action:@selector(onScan)];
    self.navigationItem.rightBarButtonItems = @[additem,scanitem];

    
    
}
#pragma mark - UIBarButtonItem Event
-(void)onMenuClicked{
    [[iAppDele mainVC] leftClick:YES];
}
@end
