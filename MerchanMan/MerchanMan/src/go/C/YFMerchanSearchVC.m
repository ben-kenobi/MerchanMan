
//
//  YFMerchanSearchVC.m
//  MerchanMan
//
//  Created by hui on 2019/4/21.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchanSearchVC.h"
#import "YFMerchanList.h"
#import "YFMerchanListTv.h"

@interface YFMerchanSearchVC ()
@property (nonatomic,strong)YFMerchanListTv *tv;

@end

@implementation YFMerchanSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)setDatas:(NSArray<YFMerchan *> *)datas{
    self.tv.datas = datas;
}


#pragma mark - UI
-(void)initUI{
    
    self.tv = [[YFMerchanListTv alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    
    
    // layout ------
    [self.view addSubview:self.tv];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
}
@end
