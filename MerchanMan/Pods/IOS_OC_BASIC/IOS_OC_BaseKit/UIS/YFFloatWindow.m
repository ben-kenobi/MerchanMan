//
//  YFFloatWindow.m
//  BatteryCam
//
//  Created by yf on 2017/12/22.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "YFFloatWindow.h"
#import "YFCate.h"
static CGRect horrect = (CGRect){20,10,104,36};
static CGRect verrect = (CGRect){15,iTopBarH+10,104,36};

@interface YFFloatWindow ()
@property (nonatomic,assign)CGRect showFrame;

@end

@implementation YFFloatWindow
-(id)initWith:(BOOL)hor
{
    CGRect frame = hor?horrect:verrect;
    self = [super initWithFrame:frame];
    if (self) {
        self.showFrame=frame;
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert + 1;
        self.layer.masksToBounds=YES;
        self.hidden=NO;
        [self setShow:NO];
//        [self makeKeyAndVisible];
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if(!self.show)
        return nil;
    return [super hitTest:point withEvent:event];
}

-(void)setShow:(BOOL)show{
    _show=show;
    if(show){
        self.frame=self.showFrame;
    }else{
        self.frame=CGRectZero;
    }
}

-(void)setShowFrame:(CGRect)showFrame{
    _showFrame=showFrame;
    if(self.show){
        self.frame=showFrame;
    }
}

-(void)setHor:(BOOL)hor{
    [self setShowFrame:hor?horrect:verrect];
}

-(void)setOrientation:(UIInterfaceOrientation)orientation{
    _orientation=orientation;
    if(orientation==UIInterfaceOrientationPortrait){
        self.hor=NO;
    }else if(orientation==UIInterfaceOrientationPortraitUpsideDown){
        self.hor=NO;
    }else if(orientation==UIInterfaceOrientationLandscapeLeft){
        self.hor=YES;
    }else if(orientation==UIInterfaceOrientationLandscapeRight){
        self.hor=YES;
    }
}


@end
