
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
#import "YFMerchanEditVC.h"



@interface YFMerchanListVC ()<UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic,strong)YFMerchanListTv *tv;

@property (nonatomic,strong)YFMerchanList * vm;

@property (nonatomic,strong)YFMerchanSearchVC *searchVC;

@property (nonatomic,strong)UIView *emptyView;

@end

@implementation YFMerchanListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.vm = YFMerchanList.shared;
    [iNotiCenter addObserver:self selector:@selector(onShorcutNoti:) name:kMerchanAddNoti object:0];
    [iNotiCenter addObserver:self selector:@selector(onShorcutNoti:) name:kMerchanScanNoti object:0];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.vm = self.vm;
}

-(void)dealloc{
    [iNotiCenter removeObserver:self];
}

-(void)onScanResult:(NSString *)result{
    NSArray *datas = [self.vm queryByCode:result];
    YFMerchanResultListVC *vc = [[YFMerchanResultListVC alloc]init];
    vc.datas = datas;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)onShorcutNoti:(NSNotification *)noti{
    if(UIViewController.curVC != self) return;
    if([noti.name isEqualToString: kMerchanAddNoti]){
        [self onAdd];
    }else if([noti.name isEqualToString:kMerchanScanNoti]){
        [self onScan];
    }
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
    [self handleEmptView];
}
-(void)onAdd{
    YFMerchanEditVC *vc = [[YFMerchanEditVC alloc]init];
    [UIViewController pushVC:vc];
}
-(void)onScan{
    [YFMerchanUtil gotoScan:^(NSString * _Nonnull result) {
        [self.navigationController popToViewController:self animated:NO];
        [self onScanResult:result];
    }];
}
-(void)handleEmptView{
    [self.emptyView removeFromSuperview];
    if(self.vm.allDatas.count == 0){
        UIButton *btn = [IProUtil commonTextBtn:iFont(18) color:iGlobalFocusColor title:@"点 击 添 加"];
        [UIUtil commonStrokeBtn:btn tar:self action:@selector(onAdd)];
        [self.tv addSubview:btn];
        self.emptyView = btn;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.width.equalTo(self.tv).multipliedBy(.7);
            make.height.equalTo(@52);
        }];
    }
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
