//
//  YFMerchan.h
//  MerchanMan
//
//  Created by hui on 2019/4/20.
//  Copyright © 2019 yf. All rights reserved.
//

#import "IUtil.h"
#import "YFCodecObj.h"


@interface YFMerchan : YFCodecObj
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSArray<NSString *> *iconPaths;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *remark;
@property (nonatomic,strong)NSString *inPrice;
@property (nonatomic,strong)NSString *outPrice;
@property (nonatomic,strong)NSDate *addTime;
@property (nonatomic,strong)NSDate *updateTime;
@end


