//
//  YFChessBtn.m
//  BetaGo
//
//  Created by yf on 2019/3/7.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFChessBtn.h"

@interface YFChessBtn ()
@property (nonatomic,weak)UILongPressGestureRecognizer *lpGest;
@end


@implementation YFChessBtn
-(void)setShowTitle:(BOOL)showTitle{
    _showTitle = showTitle;
    [self updateUI];
}

-(void)setMod:(YFChess *)mod{
    _mod = mod;
    [self updateUI];
}
-(void)setDone:(BOOL)done{
    _done = done;
    self.userInteractionEnabled = _done;
}

-(void)updateUI{
    [self setBackgroundImage:self.mod.img forState:0];
    [self setTitleColor:self.mod.titleColor forState:0];
    self.titleLabel.font = iFont(11);
    [self setTitle:self.showTitle ? self.mod.title : @"" forState:0];
    [self setTitleColor:iGlobalFocusColor forState:(UIControlStateSelected)];
}
+(instancetype)btnWith:(YFChess *)mod w:(CGFloat)wid dele:(id<YFChessLPActionDele>)dele {
    YFChessBtn *btn = [[self alloc]init];
    btn.done = NO;
    btn.mod=mod;
    btn.size = CGSizeMake(wid, wid);
//    [UIUtil commonShadowWithRadius:2 size:CGSizeMake(1, 1) view:btn opacity:mod.black?.4:.2];
    
    UILongPressGestureRecognizer *lpgest = [[UILongPressGestureRecognizer alloc]initWithTarget:dele action:@selector(onLpAction:)];
    [btn addGestureRecognizer:lpgest];
    lpgest.minimumPressDuration=.3;
    lpgest.delegate = dele;
    btn.lpGest = lpgest;
    return btn;
}

@end
