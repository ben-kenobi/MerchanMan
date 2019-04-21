//
//  YFMerchanSearchVC.h
//  MerchanMan
//
//  Created by hui on 2019/4/21.
//  Copyright © 2019 yf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFMerchanList,YFMerchan;

NS_ASSUME_NONNULL_BEGIN

@interface YFMerchanSearchVC : UISearchController
@property (nonatomic,strong)NSArray<YFMerchan *> * datas;
@end

NS_ASSUME_NONNULL_END
