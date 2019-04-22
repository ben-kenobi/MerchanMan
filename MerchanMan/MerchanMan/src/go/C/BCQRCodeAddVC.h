//
//  BCQRCodeAddVC.h
//  BatteryCam
//
//  Created by yf on 2018/8/6.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "YFBasicVC.h"

@interface BCQRCodeAddVC : YFBasicVC
@property (nonatomic,copy)void (^onScanResult)(NSString *result);
@end
