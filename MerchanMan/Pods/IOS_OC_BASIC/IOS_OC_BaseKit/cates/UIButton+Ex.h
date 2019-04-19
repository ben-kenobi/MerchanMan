//
//  UIButton+Ex.h
//  BatteryCam
//
//  Created by yf on 2017/8/5.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Ex)
+(instancetype)btnWithImg:(UIImage *)img diableColor:(UIColor *)color;
+(instancetype)btnWithImg:(UIImage *)img hlColor:(UIColor *)color;
+(instancetype)btnWithImg:(UIImage *)img hlImg:(UIImage *)hlimg;
+(instancetype)btnWithImg:(UIImage *)img selImg:(UIImage *)selimg;
+(instancetype)btnWithImg:(UIImage *)img hlImg:(UIImage *)hlimg selImg:(UIImage *)selimg;
@end
