//
//  NetUtil.m
//Created by apple on 17/07/21.
//

#import "NetUtil.h"
#import "AFNetworking.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import "YFCate.h"

@implementation NetUtil

+(void)jsonPost:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    AFHTTPSessionManager *man=[AFHTTPSessionManager manager];
    [man.securityPolicy setAllowInvalidCertificates:YES];
    [man setRequestSerializer:[AFJSONRequestSerializer serializerWithWritingOptions:0]];
    [man POST:[self fullUrl:url] parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if(callback)
            callback(responseObject,task.response,0);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(callback)
            callback(0,task.response,error);
    }];
}
+(void)post:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    AFHTTPSessionManager *man=[AFHTTPSessionManager manager];
     [man.securityPolicy setAllowInvalidCertificates:YES];
    [man POST:[self fullUrl:url] parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if(callback)
            callback(responseObject,task.response,0);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(callback)
            callback(0,task.response,error);
    }];
}
+(void)get:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    AFHTTPSessionManager *man=[AFHTTPSessionManager manager];
     [man.securityPolicy setAllowInvalidCertificates:YES];
    [man GET:[self fullUrl:url] parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if(callback)
            callback(responseObject,task.response,0);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(callback)
            callback(0,task.response,error);
    }];
    
}
+(NSString *)fullUrl:(NSString *)url{
    if([url hasPrefix:@"http://"]||[url hasPrefix:@"https://"])
        return url;
    return iFormatStr(@"%@%@",iBaseURL,url);
}

+(NSString *)paramlize:(NSDictionary *)param{
    NSMutableString *mstr=[NSMutableString string];
    [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [mstr appendFormat:@"%@=%@&",key,obj];
    }];
    [mstr deleteCharactersInRange:(NSRange){mstr.length-1,1}];
    return mstr;
}


+(NSString *)addrString:(struct sockaddr_in)addr{
    NSString *ip = [NSString stringWithUTF8String:inet_ntoa(addr.sin_addr)];
    return iFormatStr(@"%@:%d",ip,addr.sin_port);

//    return iFormatStr(@"%ud:%d",addr.sin_addr.s_addr,addr.sin_port);

}

@end
