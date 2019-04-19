//
//  BCProgressV.m
//  BatteryCam
//
//  Created by yf on 2017/10/26.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCProgressV.h"
#import "YFCate.h"
@interface BCProgressV()
{
    UIView *dots[3];
}
@end

@implementation BCProgressV

#pragma mark - exported
+(void)showAt:(UIView *)view{
    [BCProgressV.shared removeFromSuperview];
    view=view?view:frontestWindow();
    [view addSubview:BCProgressV.shared];
    [BCProgressV.shared mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [BCProgressV.shared startAnimate];
    [UIView animateWithDuration:.25 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        [BCProgressV.shared setAlpha:1];
    } completion:nil];
}
+(void)dismiss{
    [UIView animateWithDuration:.25 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        [BCProgressV.shared setAlpha:0];
    } completion:^(BOOL finished) {
        if(BCProgressV.shared.alpha==0)
            [BCProgressV.shared removeFromSuperview];
    }];
}

+(instancetype)shared{
    static BCProgressV *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[BCProgressV alloc]init];
    });
    return instance;
}

#pragma mark - actions


-(void)startAnimate{
    for(int i=0;i<3;i++){
        UIView *v = dots[i];
        CABasicAnimation *ba=[[CABasicAnimation alloc] init];
        ba.keyPath=@"transform.scale";
        ba.toValue=@(1.4);
//        ba.fromValue=@(1);
//        [ba setRemovedOnCompletion:NO];
//        [ba setFillMode:kCAFillModeForwards];
        ba.repeatCount=1000;
        ba.duration=.5;
        ba.autoreverses=YES;
        ba.timeOffset=.2*i;
        ba.timingFunction=[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
        [v.layer addAnimation:ba forKey:nil];
    }
}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    [BCProgressV.shared setAlpha:0];
    for(int i=0;i<3;i++){
        UIView *v = dots[i];
        [v.layer removeAllAnimations];
    }
}


#pragma mark - UI
-(instancetype)init{
    if(self = [super init]){
        [self initUI];
    }
    return self;
}
-(void)initUI{
    CGFloat vh = dp2po(50);
    CGFloat vw = dp2po(120);
    self.userInteractionEnabled=YES;
    UIView *view=[[UIView alloc]init];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.mas_bottom).multipliedBy(.36);
        make.width.equalTo(@(vw));
        make.height.equalTo(@(vh));
    }];
    [UIUtil commonShadow:view opacity:.05];
    view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.9];
    view.layer.cornerRadius=4;
    
    
    CGFloat dotw = dp2po(10);
    CGFloat cy = vh*.5;
    CGFloat cx = vw*.5;
    for(int i=0;i<3;i++){
        UIView *dot = [[UIView alloc]init];
        dot.backgroundColor=[UIColor whiteColor];
        dot.layer.cornerRadius=dotw*.5;
        dot.size=CGSizeMake(dotw, dotw);
        dot.cy=cy;
        dot.cx=cx+(i-1)*dotw*2;
        [view addSubview:dot];
        dots[i]=dot;
    }
    
}

@end
