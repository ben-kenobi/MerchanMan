//
//  NetUtil.h
//Created by apple on 17/07/21.
//

#import <Foundation/Foundation.h>
#import "YFCate.h"

@interface NetUtil : NSObject

+(void)post:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;

+(void)get:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;

+(void)jsonPost:(NSString *)url param:(NSDictionary *)param callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;

+(NSString *)addrString:(struct sockaddr_in)addr;
@end
