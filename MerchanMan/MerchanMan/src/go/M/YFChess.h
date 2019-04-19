//
//  YFChess.h
//  BetaGo
//
//  Created by yf on 2019/3/7.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFCodecObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFChess : YFCodecObj
@property (nonatomic,assign)BOOL black;//是否先手
@property (nonatomic,assign)int x;
@property (nonatomic,assign)int y;
@property (nonatomic,assign)int round;




#pragma mark - UI Property
@property (nonatomic,readonly)UIImage *img;
@property (nonatomic,readonly)UIColor *titleColor;
@property (nonatomic,readonly)NSString *title;
+(instancetype)chessWith:(BOOL)black;
@end

NS_ASSUME_NONNULL_END
