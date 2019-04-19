//
//  YFNoHitWin.m
//  IOS_OC_BASIC
//
//  Created by yf on 2018/12/18.
//  Copyright © 2018 yf. All rights reserved.
//

#import "YFNoHitWin.h"
#import "YFNoHitVC.h"
#import "YFCate.h"

@implementation YFNoHitWin

+(instancetype)winWithRootVC:(UIViewController *)rootVC{
    YFNoHitWin *win = [[YFNoHitWin alloc]initWithFrame:UIScreen.mainScreen.bounds];
    win.backgroundColor = [UIColor clearColor];
    win.windowLevel = UIWindowLevelAlert + 1;
    win.layer.masksToBounds=YES;
    win.rootViewController=rootVC;
    win.hidden=NO;
    return win;
}

+(instancetype)winWithCreateCB:(void (^)(UIView *view))cb{
    YFNoHitVC *vc = [[YFNoHitVC alloc]init];
    if(cb){
        cb(vc.view);
    }
    return [self winWithRootVC:vc];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if(view != self)
        return view;
    return nil;
}


#
@end
