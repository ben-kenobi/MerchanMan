//
//  BCMenuMod.m
//  BatteryCam
//
//  Created by yf on 2017/8/8.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCMenuMod.h"

@interface BCMenuMod ()

@end

@implementation BCMenuMod

-(void)setNewNotiCount:(NSInteger)newNotiCount{
    _newNotiCount=newNotiCount<0?0:newNotiCount;
}

+(instancetype)setDict:(NSDictionary *)dict{
    BCMenuMod *m = [IUtil setValues:dict forClz:self];
    if(!emptyStr(m.title))
        m.title = NSLocalizedStringFromTable(m.title, @"MenuListPlist", nil);
    return m;
}

@end
