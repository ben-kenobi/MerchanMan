
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
    [iNotiCenter postNotificationName:kMerchanDataChangeNoti object:0];
    [self archive];
}
-(BOOL)saveMerchant:(YFMerchan *)mod img:(UIImage *)img{
    if([self.merchans containsObject:mod]){
        mod.updateTime = [NSDate date];
        [self.merchans replaceObjectAtIndex:[self.merchans indexOfObject:mod] withObject:mod];
        [self save];
    }else{
        BOOL saveImgSuc = YES;
        if(img){
            saveImgSuc = [YFMerchanUtil saveImg:img ID:mod.iconIDs.firstObject];
        }
        if(saveImgSuc){
            [self add:mod];
        }else{
            return NO;
        }
    }
    return YES;
}
-(BOOL)add:(YFMerchan *)mod{
    [self.merchans insertObject:mod atIndex:0];
    [self save];
    return YES;
}
-(BOOL)rm:(YFMerchan *)mod{
    [self.merchans removeObject:mod];
    [YFMerchanUtil rmImgs:mod.iconIDs];
    [self save];
    return YES;
}
-(void)rmAt:(NSIndexPath *)indexpath{
    [self.merchans removeObject:[self getBy:indexpath]];
    [self save];
}
-(NSArray *)queryBy:(NSString *)likeName{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@",likeName];
    NSArray *ary = [self.merchans filteredArrayUsingPredicate:pre];
    return ary;
}
-(NSArray<YFMerchan *> *)queryByCode:(NSString *)barCode{
    NSMutableArray *mary = [NSMutableArray array];
    for(YFMerchan *mod in self.merchans){
        if([mod.barCode.lowercaseString isEqualToString:barCode.lowercaseString]){
            [mary addObject:mod];
        }
    }
    return [NSArray arrayWithArray:mary];
}

-(NSArray<YFMerchan *> *)allDatas{
    return self.merchans;
}

#pragma mark - init
+(instancetype)shared{
    static dispatch_once_t onceToken;
    static YFMerchanList *instance;
    dispatch_once(&onceToken, ^{
        instance = [YFMerchanList unArchive];
#if DEBUG
        YFMerchan *mod = [[YFMerchan alloc]init];
        mod.name = @"121312313f";
        mod.inPrice = @"120";
        mod.outPrice = @"240";
        mod.remark = @"remat\nwlkekrlwekrlwrentma";
        mod.iconIDs = @[iRes(@"personal_bg@2x.png")];
        mod.barCode = @"123H123";
        [instance.merchans addObject:mod];
        [instance.merchans addObject:mod];[instance.merchans addObject:mod];
        [instance.merchans addObject:mod];
        [instance.merchans addObject:mod];
        [instance.merchans addObject:mod];
        
#endif
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
