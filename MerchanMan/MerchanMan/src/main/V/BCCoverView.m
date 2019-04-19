

//
//  BCCoverView.m
//  BatteryCam
//
//  Created by yf on 2018/3/16.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "BCCoverView.h"
@interface BCCoverView()
@property (nonatomic,strong)UIButton *btn;
@end

@implementation BCCoverView

-(instancetype)init{
    if(self = [super init]){
        [self initUI];
    }
    return self;
}

-(UIView *)mask{
    if(!_mask){
        _mask=[[UIView alloc]init];
        [self addSubview:_mask];
        [_mask mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _mask;
}


+(void)showAt:(UIView *)view{
    BCCoverView *v=[[BCCoverView alloc]init];
    [view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    v.alpha=0;
    [UIView animateWithDuration:.25 animations:^{
        v.alpha=1;
    }];
}

-(void)showAt:(UIView *)view{
    [self removeFromSuperview];
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.alpha=0;
    [UIView animateWithDuration:.25 animations:^{
        self.alpha=1;
    }];
}


-(void)dismiss{
    [UIView animateWithDuration:.25 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - UI
-(void)initUI{
}

@end
