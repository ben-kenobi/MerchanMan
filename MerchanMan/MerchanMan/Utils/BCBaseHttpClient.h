//
//  BCExtensionHttpClient.h
//  BatteryCam
//
//  Created by yf on 2018/6/26.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
extern NSInteger const BC_NETWORKERR;
extern NSInteger const BC_INVALID_TOKEN;

extern NSString *const baseurl_us;
extern NSString *const baseurl_eu;
extern NSString *const baseurl_test;
extern NSString *const baseurl_ci;

@interface BCBaseHttpClient : AFHTTPSessionManager
+ (instancetype)shared;

//优先使用手动选择，为空则使用auto地址，最后使用默认地址
+(NSString *)fullUrl:(NSString *)url;
+(BOOL)isDefaultDomain;
//当前使用中的域名
+(NSString *)usingDomain;

+(NSURLSessionTask *)bcJsonPost:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSInteger code, id data, NSString* msg))callback;
+(NSURLSessionTask *)bcPost:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSInteger code, id data,NSString* msg))callback;
+(NSURLSessionTask *)bcGet:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSInteger code, id data,NSString* msg))callback;
+(NSURLSessionTask *)bcDelete:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSInteger code, id data,NSString* msg))callback;
+(NSURLSessionTask *)bcPut:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSInteger code, id data,NSString* msg))callback;

+(void)upload:(NSString *)url formdata:(NSData *)data param:(NSDictionary *)param callBack:(void (^)(NSInteger code, id data, NSString* msg))callback;

+(NSURLSessionUploadTask *)mulitiUpload:(NSString *)url files:(NSArray<NSString *> *)files  datas:(NSArray<NSData *>*)datas param:(NSDictionary *)param callBack:(void (^)(NSInteger code, id data, NSString* msg))callback prog:(void(^)(NSProgress *prog))progcb;

+(NSURLSessionUploadTask *)videoUpload:(NSString *)url files:(NSArray<NSString *> *)files  datas:(NSArray<NSData *>*)datas param:(NSDictionary *)param callBack:(void (^)(NSInteger code, id data, NSString* msg))callback prog:(void(^)(NSProgress *prog))progcb;


#pragma mark - override by subclass
+(void)setupCommonHearder:(NSMutableURLRequest *)request;
+(NSString *)handleError:(NSError *)err code:(NSInteger)code datas:(id)datas token:(NSString *)token;
#pragma mark - serverPath
/**
 selected:按照手动选择的区域判断服务器地址
 auto:按照查询区域返回的地区判断服务器地址
 serverSpecify:默认服务器指定的域名
 //优先使用手动选择，为空则使用auto地址，还空则使用默认的服务器指定的域名
 在没有选中的服务器地址时,则登录完后查询服务器一次
 */
+(NSString *)prefServerPath;
+(void)setSelectdServerPath:(NSString *)path;
+(NSString *)selectedServerPath;
+(void)setAutoServerPathBy:(NSString *)couCode;
+(NSString *)countryCodeBy:(NSString *)domain;
+(void)setAutoServerPath:(NSString *)path;

+(void)setServerSpecifiedPath:(NSString *)domain;
+(void)setServerAuthToken:(NSString *)token;
#pragma mark - implement by subclass
+(NSString *)serverSpecifiedPath;

@end
