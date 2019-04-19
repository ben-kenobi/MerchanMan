//
//  YFCodecObj.h
//  BatteryCam
//
//  Created by yf on 2018/8/1.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import <Foundation/Foundation.h>
#define iBaseCodecNCopy \
- (id)initWithCoder:(NSCoder *)coder\
{\
    if(self = [super init]){\
        NSArray *varary = [IUtil varsWithClz:self.class];\
        for(NSString *varname in varary){\
            id value = [coder decodeObjectForKey:varname];\
            if(value)\
                [self setValue:value forKey:varname];\
        }\
    }\
    return self;\
}\
- (void)encodeWithCoder:(NSCoder *)coder\
{\
    NSArray *varary = [IUtil varsWithClz:self.class];\
    for(NSString *varname in varary){\
        id value = [self valueForKey:varname];\
        if(value)\
            [coder encodeObject:value forKey:varname];\
    }\
}\
- (id)copyWithZone:(NSZone *)zone\
{\
    id copy = [[[self class] alloc]init];\
    NSArray *varary = [IUtil varsWithClz:self.class];\
    for(NSString *varname in varary){\
        id value = [self valueForKey:varname];\
        if(value)\
            [copy setValue:value forKey:varname];\
    }\
    return copy;\
}\
-(void)archiveTo:(NSString *)path{\
    [NSKeyedArchiver archiveRootObject:self toFile:path];\
}\
+(instancetype)unArchiveFrom:(NSString *)path{\
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];\
}
@interface YFCodecObj : NSObject<NSCopying,NSCoding>

@end
