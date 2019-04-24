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

+(NSString *)fullImgPathByID:(NSString *)ID;
+(BOOL)saveImg:(UIImage *)img ID:(NSString *)ID;
+(BOOL)rmImgs:(NSArray<NSString *> *)IDS;
+(NSString *)appendToDocPath:(NSString *)subpath;




#pragma mark - goto
+(void)gotoScan:(void (^)(NSString *result))cb;

+(void)gotoAlbum:(id)delegate edit:(BOOL)edit;
+(void)gotoCamera:(id)delegate edit:(BOOL)edit;

+(void)photoChooser:(id)dele;
+(void)gotoAppSetting;

@end

NS_ASSUME_NONNULL_END
