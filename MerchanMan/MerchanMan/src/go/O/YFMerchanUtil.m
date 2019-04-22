
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
+(void)gotoScan{
    BCQRCodeAddVC *vc = [[BCQRCodeAddVC alloc]init];
    [UIViewController pushVC:vc];
}
+(void)postScanResult:(NSString *)result{
    [iNotiCenter postNotificationName:kYFMerchanScanCodeNoti object:result];
}
@end
