//
//  YFMerchanListTv.m
//  MerchanMan
//
//  Created by hui on 2019/4/21.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchanListTv.h"
#import "YFMerchanList.h"
#import "YFMerchantCell.h"
#import "YFMerChan.h"


static NSString *celliden = @"celliden";

@interface YFMerchanListTv ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation YFMerchanListTv

-(void)setDatas:(NSArray<YFMerchan *> *)datas{
    _datas = datas.copy;
    [self reloadData];
}

#pragma mark - UITableviewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFMerchantCell *cell = (YFMerchantCell *)[tableView dequeueReusableCellWithIdentifier:celliden];
    YFMerchan *mod = self.datas[indexPath.row];
    cell.mod = mod;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YFMerchan *mod = self.datas[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    YFMerchan *mod = self.datas[indexPath.row];
    [YFMerchanList.shared rm:mod];
    NSMutableArray *mary = [NSMutableArray arrayWithArray:self.datas];
    [mary removeObject:mod];
    self.datas = mary;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}



#pragma mark - init

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self = [super initWithFrame:frame style:style]){
        [self initUI];
    }
    return self;
}


-(void)initUI{
    self.bounces=YES;
    self.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableFooterView=[[UIView alloc]init];
    self.delegate=self;
    self.dataSource=self;
    self.backgroundColor=iColor(0xFB, 0xFB, 0xFB, 1);
    [self registerClass:[YFMerchantCell class] forCellReuseIdentifier:celliden];
    self.rowHeight=UITableViewAutomaticDimension;
    self.estimatedRowHeight = 100;
    
}
@end
