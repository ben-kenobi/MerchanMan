
//
//  YFGoMainVC.m
//  BetaGo
//
//  Created by yf on 2019/3/7.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchanListVC.h"
#import "YFMerchanList.h"
#import "YFMerchan.h"
#import "YFMerchantCell.h"

static NSString *celliden = @"celliden";


@interface YFMerchanListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tv;

@property (nonatomic,strong)YFMerchanList * vm;

@end

@implementation YFMerchanListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.vm = YFMerchanList.shared;
    
}

#pragma mark - UITableviewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.vm secCount];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.vm rowCountBy:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFMerchantCell *cell = (YFMerchantCell *)[tableView dequeueReusableCellWithIdentifier:celliden];
    YFMerchan *mod = [self.vm getBy:indexPath];
    cell.mod = mod;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YFMerchan *mod = [self.vm getBy:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

    
    self.tv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tv.bounces=YES;
    self.tv.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tv.tableFooterView=[[UIView alloc]init];
    self.tv.delegate=self;
    self.tv.dataSource=self;
    self.tv.backgroundColor=iColor(0xFB, 0xFB, 0xFB, 1);
    [self.tv registerClass:[YFMerchantCell class] forCellReuseIdentifier:celliden];
    self.tv.rowHeight=UITableViewAutomaticDimension;
    self.tv.estimatedRowHeight = 100;
    
    
    
    // layout ------
    [self.view addSubview:self.tv];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
}
#pragma mark - UIBarButtonItem Event
-(void)onMenuClicked{
    [[iAppDele mainVC] leftClick:YES];
}
@end
