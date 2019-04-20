
//
//  YFMerchanList.m
//  MerchanMan
//
//  Created by hui on 2019/4/20.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchanList.h"
#import "YFMerchan.h"

@interface YFMerchanList()
@property (nonatomic,strong)NSMutableArray<YFMerchan *> *merchans;
@end


@implementation YFMerchanList

#pragma mark - exported

-(NSInteger)secCount{
    return self.merchans.count > 0 ? 1 : 0;
}
-(NSInteger)rowCountBy:(NSInteger)sec{
    return self.merchans.count;
}
-(YFMerchan *)getBy:(NSIndexPath *)idxpath{
    return self.merchans[idxpath.row];
}
-(void)save{
    [self archive];
}
-(void)saveMerchant:(YFMerchan *)mod{
    mod.updateTime = [NSDate date];
    if([self.merchans containsObject:mod]){
        [self.merchans replaceObjectAtIndex:[self.merchans indexOfObject:mod] withObject:mod];
        [self save];
    }else{
        [self add:mod];
    }

}
-(void)add:(YFMerchan *)mod{
    [self.merchans insertObject:mod atIndex:0];
    [self save];
}
-(void)rm:(YFMerchan *)mod{
    [self.merchans removeObject:mod];
    [self save];
}
-(void)rmAt:(NSIndexPath *)indexpath{
    [self.merchans removeObject:[self getBy:indexpath]];
    [self save];
}
-(NSArray *)queryBy:(NSString *)likeName{
    return nil;
}



#pragma mark - init
+(instancetype)shared{
    static dispatch_once_t onceToken;
    static YFMerchanList *instance;
    dispatch_once(&onceToken, ^{
        instance = [YFMerchanList unArchive];
    });
    return instance;
}



-(void)archive{
    //1、存在主应用沙盒文件
    runOnGlobal(^{
        [NSKeyedArchiver archiveRootObject:self toFile:[@"YFMerchanList" strByAppendToDocPath]];
    });
}
+(instancetype)unArchive{
    YFMerchanList *instance = nil;
    
    //1、主应用沙盒文件获取
    instance = [NSKeyedUnarchiver unarchiveObjectWithFile:[@"YFMerchanList" strByAppendToDocPath]];
    if(instance){
        return instance;
    }
    instance=[[YFMerchanList alloc]init];
    return instance;
}

iLazy4Ary(merchans, _merchans)

#pragma mark - codec
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.merchans forKey:@"merchans"];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.merchans=[coder decodeObjectForKey:@"merchans"];
    }
    return self;
}

@end
