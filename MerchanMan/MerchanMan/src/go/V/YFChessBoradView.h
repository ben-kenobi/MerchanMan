//
//  YFChessBoradView.h
//  BetaGo
//
//  Created by yf on 2019/3/7.
//  Copyright © 2019 yf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFMatch.h"
#import "YFChessBtn.h"



@interface YFChessBoradView : UIView
-(instancetype)initWith:(YFMatch *)match;

@property (nonatomic,strong)YFChessBtn *curChess;

-(void)confirmAddChess;
@end


