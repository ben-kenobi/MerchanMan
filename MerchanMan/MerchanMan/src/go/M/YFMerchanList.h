//
//  YFMerchanList.h
//  MerchanMan
//
//  Created by hui on 2019/4/20.
//  Copyright © 2019 yf. All rights reserved.
//

#import "IUtil.h"
#import "YFCodecObj.h"

@class YFMerchan;
NS_ASSUME_NONNULL_BEGIN

@interface YFMerchanList : YFCodecObj
+(instancetype)shared;

-(NSInteger)secCount;
-(NSInteger)rowCountBy:(NSInteger)sec;
-(YFMerchan *)getBy:(NSIndexPath *)idxpath;
-(void)save;
-(void)saveMerchant:(YFMerchan *)mod;
-(void)add:(YFMerchan *)mod;
-(void)rm:(YFMerchan *)mod;
-(void)rmAt:(NSIndexPath *)idxpath;
-(NSArray *)queryBy:(NSString *)likeName;
@end

NS_ASSUME_NONNULL_END
