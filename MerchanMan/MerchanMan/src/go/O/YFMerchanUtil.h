//
//  YFMerchanUtil.h
//  MerchanMan
//
//  Created by yf on 2019/4/22.
//  Copyright © 2019 yf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFMerchanUtil : NSObject
+(void)gotoScan:(void (^)(NSString *result))cb;
@end

NS_ASSUME_NONNULL_END
