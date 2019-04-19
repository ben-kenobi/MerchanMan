//
//  BCProgressV.h
//  BatteryCam
//
//  Created by yf on 2017/10/26.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCProgressV : UIView

+(void)showAt:(UIView *)view;
+(void)dismiss;
+(instancetype)shared;
@end
