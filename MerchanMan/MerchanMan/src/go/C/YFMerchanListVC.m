
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
#import "YFMerchanSearchVC.h"
#import "YFMerchanListTv.h"
#import "YFMerchanResultListVC.h"



@interface YFMerchanListVC ()<UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic,strong)YFMerchanListTv *tv;

@property (nonatomic,strong)YFMerchanList * vm;

@property (nonatomic,strong)YFMerchanSearchVC *searchVC;

@end

@implementation YFMerchanListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.vm = YFMerchanList.shared;
    [iNotiCenter addObserver:self selector:@selector(onScanResult:) name:kYFMerchanScanCodeNoti object:nil];
}
-(void)dealloc{
    [iNotiCenter removeObserver:self];
}

-(void)onScanResult:(NSNotification *)noti{
    NSString *result = noti.object;
    NSArray *datas = [self.vm queryByCode:result];
    YFMerchanResultListVC *vc = [[YFMerchanResultListVC alloc]init];
    vc.datas = datas;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UISearchControllerDelegate
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *text = searchController.searchBar.text;
    NSArray *datas = [self.vm queryBy:text];
    self.searchVC.datas = datas;
}

- (void)willDismissSearchController:(UISearchController *)searchController{
    self.vm = self.vm;
}


#pragma mark - actions

-(void)setVm:(YFMerchanList *)vm{
    _vm = vm;
    self.tv.datas = vm.allDatas;
}
-(void)onAdd{
    
}
-(void)onScan{
    [YFMerchanUtil gotoScan];
}



#pragma mark - UI
-(void)initUI{
    self.title = @"商品列表";
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:img(@"sensitivity_icon") style:(UIBarButtonItemStylePlain) target:self action:@selector(onMenuClicked)];
    UIBarButtonItem *additem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(onAdd)];
    UIBarButtonItem *scanitem = [[UIBarButtonItem alloc]initWithImage:[img(@"scanicon") renderWithColor:iColor(0x44, 0x44, 0x44, 1)] style:UIBarButtonItemStylePlain target:self action:@selector(onScan)];
    self.navigationItem.rightBarButtonItems = @[additem,scanitem];

    
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    self.searchVC = [[YFMerchanSearchVC alloc]initWithSearchResultsController:nil];
    self.searchVC.delegate =  self;
    self.searchVC.searchResultsUpdater = self;
    self.searchVC.searchBar.delegate = self;
    self.navigationItem.searchController = self.searchVC;
    self.definesPresentationContext = YES;
    
    self.tv = [[YFMerchanListTv alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
   
    
    
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
