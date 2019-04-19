

//
//  YFWeakRef.m
//  IOS_OC_BASIC
//
//  Created by yf on 2019/1/22.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFWeakRef.h"

@interface YFWeakRef ()
@end

@implementation YFWeakRef
- (instancetype) initWithObj:(id)obj
{
    if(self = [super init]){
        _obj = obj;
    }return self;
}
+(instancetype)refWith:(id)obj{
    return [[self alloc]initWithObj:obj];
}
@end
