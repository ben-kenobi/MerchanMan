//
//  M1GuidanceView.m
//  M1Remoter
//
//  Created by yf on 2017/10/24.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "M1GuidanceView.h"
#import "YFCate.h"

@interface M1GuidanceView()
@property (nonatomic,strong)UIButton *btn;
@end

@implementation M1GuidanceView

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
     M1GuidanceView *v=[[M1GuidanceView alloc]init];
    [view addSubview:v];
    [v updateAsynchronously:YES completion:^{
        v.frame = view.bounds;
    }];
    v.alpha=0;
    [UIView animateWithDuration:.25 animations:^{
        v.alpha=1;
    }];
}

-(void)showAt:(UIView *)view{
    [self removeFromSuperview];
    [view addSubview:self];
    [self updateAsynchronously:YES completion:^{
        self.frame = view.bounds;
    }];
    self.alpha=0;
    [UIView animateWithDuration:.25 animations:^{
        self.alpha=1;
    }];
}

+(void)showBy:(UIView *(^)(M1GuidanceView *v))cb{
    M1GuidanceView *v=[[M1GuidanceView alloc]init];
    UIView *view = cb(v);
    [v updateAsynchronously:YES completion:^{
        v.frame = view.bounds;
    }];
    v.alpha=0;
    [UIView animateWithDuration:.25 animations:^{
        v.alpha=1;
    }];
}

-(void)showBy:(UIView *(^)(M1GuidanceView *v))cb{
    [self removeFromSuperview];
    UIView *view = cb(self);
    [self updateAsynchronously:YES completion:^{
        self.frame = view.bounds;
    }];
    self.alpha=0;
    [UIView animateWithDuration:.25 animations:^{
        self.alpha=1;
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:.15 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - UI
-(void)initUI{
    self.dynamic = NO;
    self.tintColor = [UIColor blackColor];
    self.contentMode = UIViewContentModeBottom;
    self.blurRadius=4;
}

@end
