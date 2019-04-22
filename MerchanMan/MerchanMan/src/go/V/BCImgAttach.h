//
//  BCImgAttach.h
//  BatteryCam
//
//  Created by yf on 2017/11/7.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCImgAttach :NSTextAttachment
@property(nonatomic,copy)NSString *path;
+(NSAttributedString *)attStrWith:(UIImage *)img path:(NSString *)path;
@end
