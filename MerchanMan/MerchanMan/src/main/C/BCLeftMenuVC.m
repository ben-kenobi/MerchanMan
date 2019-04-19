//
//  BCLeftMenuVC.m
//  BatteryCam
//
//  Created by yf on 2017/8/8.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCLeftMenuVC.h"
#import "BCUserInfoCell.h"
#import "BCMenuCell.h"
#import "BCMenuList.h"
#import "YFMainVC2.h"


static NSString *celliden = @"celliden";

@interface BCLeftMenuVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tv;
@property(nonatomic,strong)BCUserInfoCell *userInfoCell;
@property(nonatomic,strong)BCMenuList *menuList;
@property(nonatomic,strong)UIButton *logoutBtn;

@end

@implementation BCLeftMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=iColor(0xfb, 0xfb, 0xfb, 1);
    self.preferredContentSize=CGSizeMake(iScreenW*(1-vScaleRight), iScreenH);
    [self initUI];
    self.menuList=[[BCMenuList alloc] init];
 
    
}


#pragma mark - actions
-(void)stateChange{
    [self.userInfoCell updateUserInfo];
}
#pragma mark - UITableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BCMenuCell *cell = (BCMenuCell*)[tableView dequeueReusableCellWithIdentifier:celliden];
    cell.mod=[self.menuList get:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.menuList clickOn:indexPath.row];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView reloadData];
    });
}




#pragma mark - UI

-(void)initUI{
    self.view.backgroundColor=iColor(0xFB, 0xFB, 0xFB, 1);
    UIImage *img = img(@"personal_bg");
    BCUserInfoCell *cell = [[BCUserInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@""];
    
    cell.frame=CGRectMake(0, 0, self.preferredContentSize.width, self.preferredContentSize.width*(img.h/img.w));
    
    self.userInfoCell=cell;
    self.userInfoCell.cb = ^{
    };
    [cell updateUserInfo];
    
    self.tv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tv.bounces=YES;
    self.tv.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tv.tableFooterView=[[UIView alloc]init];
    self.tv.delegate=self;
    self.tv.dataSource=self;
    self.tv.backgroundColor=iColor(0xFB, 0xFB, 0xFB, 1);
    [self.tv registerClass:[BCMenuCell class] forCellReuseIdentifier:celliden];
    self.tv.rowHeight=dp2po(46);
 
    

    // layout ------
    [self.view addSubview:cell];
    [self.view addSubview:self.tv];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.equalTo(@0);
        make.top.equalTo(cell.mas_bottom).offset(dp2po(20));
        make.width.equalTo(self.view.mas_width).multipliedBy(1);
    }];

}

@end
