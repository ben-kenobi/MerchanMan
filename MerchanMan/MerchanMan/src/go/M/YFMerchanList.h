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

-(void)save;
-(BOOL)saveMerchant:(YFMerchan *)mod img:(UIImage *)img;
-(BOOL)rm:(YFMerchan *)mod;
-(NSArray<YFMerchan *> *)queryBy:(NSString *)likeName;
-(NSArray<YFMerchan *> *)queryByCode:(NSString *)barCode;
-(NSArray<YFMerchan *> *)allDatas;
@end

NS_ASSUME_NONNULL_END
