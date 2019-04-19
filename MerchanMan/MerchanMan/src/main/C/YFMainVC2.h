//
//  YFMainVC2.h
//  BatteryCam
//
//  Created by yf on 2017/10/27.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>
#define vScaleRight .28
@class YFTabbarVC;
@interface YFMainVC2 : UIViewController
@property (nonatomic,strong)UIButton *cover;
@property (nonatomic,strong)void(^onCoverRm)(void);
@property (nonatomic,assign)BOOL isScale;
-(void)coverClick:(BOOL)animated;
-(void)leftClick:(BOOL)animated;
@end
