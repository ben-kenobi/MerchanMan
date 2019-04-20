

//
//  YFMerchan.m
//  MerchanMan
//
//  Created by hui on 2019/4/20.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchan.h"

@implementation YFMerchan

-(instancetype)initYFMerchan{
    if(self = [super init]){
        self.ID = [NSUUID UUID].UUIDString;
        self.addTime = [NSDate date];
        self.updateTime = [NSDate date];
        self.remark = @"";
        self.name = @"";
    }return self;
}

-(BOOL)isEqual:(id)object{
    if(!object) return NO;
    if(![object isKindOfClass:YFMerchan.class]) return NO;
    YFMerchan *other = object;
    return [other.ID isEqual:self.ID];
}
@end
