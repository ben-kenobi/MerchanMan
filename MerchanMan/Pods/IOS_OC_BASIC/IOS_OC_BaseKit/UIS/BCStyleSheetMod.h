//
//  BCStyleSheetMod.h
//  BatteryCam
//
//  Created by yf on 2017/8/16.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BCStyleSheetMod;

@protocol BCStyleSheetListDelegate <NSObject>

-(NSInteger)count;
-(BCStyleSheetMod *)get:(NSInteger)idx;

@end

@interface BCStyleSheetMod : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)UIImage *icon;
@property (nonatomic,strong)UIColor *titleColor;
@property (nonatomic,copy)void (^cb)(void);


@end
