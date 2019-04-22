
//
//  YFMerchanUtil.m
//  MerchanMan
//
//  Created by yf on 2019/4/22.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchanUtil.h"
#import "BCQRCodeAddVC.h"

@implementation YFMerchanUtil
+(void)gotoScan:(void (^)(NSString *result))cb{
    BCQRCodeAddVC *vc = [[BCQRCodeAddVC alloc]init];
    vc.onScanResult = cb;
    [UIViewController pushVC:vc];
}

@end
