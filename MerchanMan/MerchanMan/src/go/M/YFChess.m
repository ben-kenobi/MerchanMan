


//
//  YFChess.m
//  BetaGo
//
//  Created by yf on 2019/3/7.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFChess.h"
@interface YFChess()
@end

@implementation YFChess
+(instancetype)chessWith:(BOOL)black{
    YFChess *chess = [[self alloc]init];
    chess.black = black;
    return chess;
}


-(UIImage *)img{
    UIColor *color = self.black ? iColor(0x33, 0x33, 0x33, 1) : iColor(0xef, 0xef, 0xef, 1);
    return [UIImage dotImg4Color:color rad:dp2po(7) imgSize:CGSizeMake(dp2po(16), dp2po(16))];
}
-(UIColor *)titleColor{
    return !self.black ? iColor(0x33, 0x33, 0x33, 1) : iColor(0xef, 0xef, 0xef, 1);
}
-(NSString *)title{
    return iFormatStr(@"%d",self.round);
}

@end
