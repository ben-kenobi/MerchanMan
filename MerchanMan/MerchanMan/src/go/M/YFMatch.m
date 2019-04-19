//
//  YFMatch.m
//  BetaGo
//
//  Created by yf on 2019/3/7.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMatch.h"


@implementation YFMatch
-(instancetype)initMatchWith:(int)lines{
    if(self = [super init]){
        self.board = [[YFChessBoard alloc]initWithLines:lines];
        
        //TODO TEST
        for(int i=0;i<9;i++){
            [self beginNextRound];
            [self canPlayThisRoundAt:i y:0];
            [self doneThisRound];
        }
        self.showRound=YES;
        self.needConfirm=NO;
    }return self;
}

-(void)setShowRound:(BOOL)showRound{
    _showRound=showRound;
}



#pragma mark - round
-(void)beginNextRound{
    switch (self.roundType) {
        case RoundTypeNormal:
            self.round += 1;
            self.curChess = [YFChess chessWith:self.round%2];
            break;
        case RoundTypeBlack:
            self.curChess = [YFChess chessWith:YES];
            break;
        case RoundTypeWhite:
            self.curChess = [YFChess chessWith:NO];
            break;
    }
    self.curChess.round = self.round;
}
-(BOOL)canPlayThisRoundAt:(int)x y:(int)y{
    x = MIN(MAX(0, x),self.board.numOfLines-1);
    y = MIN(MAX(0, y),self.board.numOfLines-1);
    return [self chess:self.curChess canPlayAtX:x y:y];
}
-(void)doneThisRound{
    [self.board addChess:self.curChess];
}
-(void)prevRound{
    
}

-(BOOL)chess:(YFChess *)chess canPlayAtX:(int)x y:(int)y{
    chess.x = x;chess.y = y;
    return [self.board canAdd:chess];
}

#pragma mark - move
-(BOOL)canPlayAt:(int)x y:(int)y{
    x = MIN(MAX(0, x),self.board.numOfLines-1);
    y = MIN(MAX(0, y),self.board.numOfLines-1);
    return [self.board canPlayAtX:x y:y];
}
-(void)move:(YFChess *)chess toX:(int)x y:(int)y{
    [self.board rmChess:chess];
    chess.x = x;chess.y = y;
    [self.board addChess:chess];
}


@end
