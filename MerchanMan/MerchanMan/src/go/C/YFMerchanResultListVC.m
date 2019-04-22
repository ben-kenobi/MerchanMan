//
//  YFMerchanResultListVC.m
//  MerchanMan
//
//  Created by yf on 2019/4/22.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchanResultListVC.h"
#import "YFMerchanList.h"
#import "YFMerchanListTv.h"


@interface YFMerchanResultListVC ()
@property (nonatomic,strong)YFMerchanListTv *tv;

@end

@implementation YFMerchanResultListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.datas = self.datas;
}

-(void)setDatas:(NSArray<YFMerchan *> *)datas{
    _datas = datas;
    self.tv.datas = datas;
    self.tv.hidden = _datas.count <= 0;
}


#pragma mark - UI
-(void)initUI{
    self.title = @"扫码结果";
    self.tv = [[YFMerchanListTv alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    UILabel *lab = [IProUtil commonLab:iBFont(18) color:iColor(0x99, 0x99, 0x99, 1)];
    lab.text = @"没有相关数据";
    
    // layout ------
    [self.view addSubview:lab];
    [self.view addSubview:self.tv];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
}
@end
