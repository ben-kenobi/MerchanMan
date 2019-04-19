//
//  UIImage+AV.m
//  IOS_OC_BASIC
//
//  Created by yf on 2018/8/8.
//  Copyright © 2018年 yf. All rights reserved.
//

#import "UIImage+AV.h"
#import <ImageIO/ImageIO.h>
#import "H264VideoParser.h"
#import <AVFoundation/AVFoundation.h>
#import<QuartzCore/QuartzCore.h>
#import<Accelerate/Accelerate.h>
#import "YFCate.h"
@implementation UIImage (AV)

+(instancetype)imgFromH264Data:(NSData *)data{
    if(!data||!data.length)return nil;
    return [self img4CVPixel:[H264VideoParser parseData:data]];
}
+(instancetype)imgFromH264File:(NSString *)path{
    if(![iFm fileExistsAtPath:path isDirectory:0])
        return nil;
    return [self img4CVPixel:[H264VideoParser parseFile:path]];
}


@end
