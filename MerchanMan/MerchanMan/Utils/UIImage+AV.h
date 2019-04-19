//
//  UIImage+AV.h
//  IOS_OC_BASIC
//
//  Created by yf on 2018/8/8.
//  Copyright © 2018年 yf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AV)
+(instancetype)imgFromH264Data:(NSData *)data;
+(instancetype)imgFromH264File:(NSString *)path;
@end
