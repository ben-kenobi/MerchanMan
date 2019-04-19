//
//  BCMenuMod.h
//  BatteryCam
//
//  Created by yf on 2017/8/8.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCMenuMod : NSObject
@property (nonatomic,copy)NSString *iconname;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,assign)BOOL hasNews;
@property (nonatomic,assign)NSInteger newNotiCount;
@property (nonatomic,copy)NSString *vcName;

@end
