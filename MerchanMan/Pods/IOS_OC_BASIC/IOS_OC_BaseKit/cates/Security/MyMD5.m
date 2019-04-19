//
//  MD5.m
//  QDLesson
//
//  Created by Ricky on 15/6/9.
//  Copyright (c) 2015年 Ricky. All rights reserved.
//

#import "MyMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MyMD5

+ (NSString *)MD5Encrypt:(NSString *)str
{
    const char *concat_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, (unsigned int)strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
    
}

@end
