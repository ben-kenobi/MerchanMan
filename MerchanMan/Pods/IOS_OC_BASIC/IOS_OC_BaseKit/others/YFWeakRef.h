//
//  YFWeakRef.h
//  IOS_OC_BASIC
//
//  Created by yf on 2019/1/22.
//  Copyright © 2019 yf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFWeakRef : NSObject
@property (nonatomic, weak) id obj;
+(instancetype)refWith:(id)obj;
@end

NS_ASSUME_NONNULL_END
