//
//  BCManualEnterSNVC.h
//  BatteryCam
//
//  Created by yf on 2018/11/15.
//  Copyright © 2018 oceanwing. All rights reserved.
//

#import "YFBasicVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BCManualEnterSNVC : YFBasicVC
@property (nonatomic,copy)void(^resultCB)(NSString *sn);
@end

NS_ASSUME_NONNULL_END
