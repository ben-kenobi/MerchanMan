//
//  BCMenuList.h
//  BatteryCam
//
//  Created by yf on 2017/8/8.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BCMenuMod.h"
@interface BCMenuList : NSObject
@property(nonatomic,strong)NSMutableArray *menulist;
-(void)setMsgNews:(NSInteger)count;
-(NSInteger)count;
-(BCMenuMod *)get:(NSInteger)idx;
-(void)clickOn:(NSInteger)idx;
@end
