//
//  FileUtil.h
//Created by apple on 17/07/21.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

+(long long)fileSizeAtPath:(NSString *)path;

+(NSString *)cachePath;
+(NSString *)docPath;
+(NSString *)tempPath;
+(void)clearFileAtPath:(NSString *)path;
+(NSString *)formatedFileSize:(long long)size;
+(NSString *)formatedFileSize2:(long long)size;
+(NSString *)formatedFileSize3:(long long)size;
+(void)rmFiles:(NSArray<NSString *> *)pathlist;
@end
