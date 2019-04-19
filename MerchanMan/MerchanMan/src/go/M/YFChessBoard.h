//
//  YFChessBoard.h
//  BetaGo
//
//  Created by yf on 2019/3/7.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFCodecObj.h"
#import "YFChess.h"
NS_ASSUME_NONNULL_BEGIN

@interface YFChessBoard : YFCodecObj
@property (nonatomic,assign)int numOfLines;


-(instancetype)initWithLines:(int)lines;

#pragma mark - 增删改查
-(YFChess *)findChessAt:(int)x y:(int)y;
-(BOOL)addChess:(YFChess *)chess;
-(BOOL)rmChess:(YFChess *)chess;
-(BOOL)replaceChess:(YFChess *)chess;
-(BOOL)canAdd:(YFChess *)chess;
-(BOOL)canPlayAtX:(int)x y:(int)y;

#pragma mark - UI property
@property (nonatomic,readonly)UIImage *bgImg;
@property (nonatomic,readonly)UIColor *lineColor;
@property (nonatomic,readonly)UIColor *borderColor;
-(UIColor *)hlLineColor;
-(UIColor *)errLineColor;
@end

NS_ASSUME_NONNULL_END
