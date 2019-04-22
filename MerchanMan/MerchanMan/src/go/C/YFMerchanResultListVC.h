//
//  YFMerchanResultListVC.h
//  MerchanMan
//
//  Created by yf on 2019/4/22.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFBasicVC.h"
@class YFMerchanList,YFMerchan;

NS_ASSUME_NONNULL_BEGIN

@interface YFMerchanResultListVC : YFBasicVC
@property (nonatomic,strong)NSArray<YFMerchan *> * datas;

@end

NS_ASSUME_NONNULL_END
