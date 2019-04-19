//
//  YFNoHitView.m
//  IOS_OC_BASIC
//
//  Created by yf on 2018/12/18.
//  Copyright © 2018 yf. All rights reserved.
//

#import "YFNoHitView.h"

@implementation YFNoHitView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if(view != self)
        return view;
    return nil;
}
@end
