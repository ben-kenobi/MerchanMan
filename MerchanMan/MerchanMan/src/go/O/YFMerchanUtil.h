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
+(void)gotoAppSetting;

+(NSString *)fullImgPathByID:(NSString *)ID;
+(BOOL)saveImg:(UIImage *)img ID:(NSString *)ID;
+(BOOL)rmImgs:(NSArray<NSString *> *)IDS;

+(void)gotoScan:(void (^)(NSString *result))cb;


+(void)gotoAlbum:(id)delegate edit:(BOOL)edit;
+(void)gotoCamera:(id)delegate edit:(BOOL)edit;

+(void)photoChooser:(id)dele;
@end

NS_ASSUME_NONNULL_END
