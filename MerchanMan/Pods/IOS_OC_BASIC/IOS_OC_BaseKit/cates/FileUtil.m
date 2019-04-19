//
//  FileUtil.m
//Created by apple on 17/07/21.
//

#import "FileUtil.h"
#import "YFCate.h"
@implementation FileUtil

+(long long)fileSizeAtPath:(NSString *)path{
    BOOL b=0;
    if([iFm fileExistsAtPath:path isDirectory:&b]){
        if(!b)
            return [[iFm attributesOfItemAtPath:path error:0][NSFileSize] longLongValue];
        else{
            long long size=0;
           NSArray *subpaths= [iFm subpathsAtPath:path];
            for(NSString * file in subpaths){
                size+=[[iFm attributesOfItemAtPath:[path stringByAppendingPathComponent:file] error:0 ][NSFileSize] longLongValue];
            }
            return size;
        }
    }
    return 0;
}

+(NSString *)formatedFileSize3:(long long)size{
    NSString *strs[5]={@"B",@"K",@"M",@"G",@"T"};
    int idx=0;
    double resul=size;
    while (idx<4&&resul>1000) {
        if(idx==0)
            resul=size/1000.0;
        else
            resul=resul/1000.0;
        idx++;
    }
    if(idx==0)
        return [NSString stringWithFormat:@"%lld%@",size,strs[idx]];
    else
        return [NSString stringWithFormat:@"%.1f%@",resul,strs[idx]];
}

+(NSString *)formatedFileSize2:(long long)size{
    NSString *strs[5]={@"B",@"K",@"M",@"G",@"T"};
    int idx=0;
    double resul=size;
    while (idx<4&&resul>1000) {
        if(idx==0)
            resul=size/1000.0;
        else
            resul=resul/1000.0;
        idx++;
    }
    if(idx==0)
        return [NSString stringWithFormat:@"%lld%@",size,strs[idx]];
    else
        return [NSString stringWithFormat:@"%.2f%@",resul,strs[idx]];
}


+(NSString *)formatedFileSize:(long long)size{
    NSString *strs[5]={@"B",@"K",@"M",@"G",@"T"};
    int idx=0;
    double resul=size;
    while (idx<4&&resul>1024) {
        if(idx==0)
            resul=size/1024.0;
        else
            resul=resul/1024.0;
        idx++;
    }
    if(idx==0)
        return [NSString stringWithFormat:@"%lld %@",size,strs[idx]];
    else
        return [NSString stringWithFormat:@"%.2f %@",resul,strs[idx]];
}

+(NSString *)cachePath{
    return  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}
+(NSString *)docPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}
+(NSString *)tempPath{
    return NSTemporaryDirectory();
}

+(void)clearFileAtPath:(NSString *)path{
    BOOL isdir=NO;
    if([iFm fileExistsAtPath:path isDirectory:&isdir]){
        if(!isdir){
            [iFm removeItemAtPath:path error:0];
            return;
        }
        NSArray *files=[iFm subpathsAtPath:path];
        for(NSString *file in files){
            NSString *absfile=[path stringByAppendingPathComponent:file];
            [iFm removeItemAtPath:absfile error:0];
        }
    }
}
+(void)rmFiles:(NSArray<NSString *> *)pathlist{
    for(NSString * path in pathlist){
        [self clearFileAtPath:path];
    }
}

@end
