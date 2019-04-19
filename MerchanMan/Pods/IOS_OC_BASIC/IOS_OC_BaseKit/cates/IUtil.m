//
//  IUtil.m
//Created by apple on 17/07/21.
//

#import "IUtil.h"
#import "objc/runtime.h"
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import "YFCate.h"

static void SystemWideNotiCallback(CFNotificationCenterRef center,
                               void *observer,
                               CFStringRef name,
                               const void *object,
                               CFDictionaryRef userInfo)
{
    id cb = (__bridge id)observer;
    ((void(^)(void))cb)();
}


CGFloat dp2po(CGFloat dp){
    CGFloat w = MIN(iScreenH,iScreenW);
    return w*dp/375;
}
int scale(void){
    int scale = iScreen.scale;
    return scale==3?3:2;
}
NSString *scaledImgName(NSString * name,NSString *ext){
    return iFormatStr(@"%@@%dx.%@",name,scale(),ext);
}

BOOL emptyStr(NSString *str){
    return !str||!str.length;
}
id nilID(void){
    return nil;
}
UIApplication *mainApp(void){
    static UIApplication *app=nil;
    if(!app){
        SEL selector = NSSelectorFromString(@"sharedApplication");
        if([UIApplication respondsToSelector:selector]){
            NSInvocation *invocation=[NSInvocation invocationWithMethodSignature:[[UIApplication class]methodSignatureForSelector:selector] ];
            [invocation setSelector:selector];
            [invocation setTarget:[UIApplication class]];
            [invocation invoke];
            id returnValue;
            [invocation getReturnValue:&returnValue];
            app=returnValue;
        }
    }
    return app;
}
BOOL nullObj(id obj){
    return obj==nil||[obj isKindOfClass:[NSNull class]];
}

@implementation IUtil
+(NSString *)getTimestamp{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
}

+(void)broadcast:(NSString *)mes info:(NSDictionary *)info{
    [[NSNotificationCenter defaultCenter] postNotificationName:mes object:0 userInfo:info];
}
+(float)systemVersion{
    return  [[UIDevice currentDevice].systemVersion floatValue];
}
+(NSInteger)appVersion{
//    NSString *appVersion=[IUtil appVersionStr];
//    NSArray *charArr=[appVersion componentsSeparatedByString:@"."];
//    NSInteger version_code=0;
//    for (int i=0; i<charArr.count; i++) {
//        version_code+=[[charArr objectAtIndex:i] integerValue]*(i==0?100:(i==1?10:1));
//    }
//    return version_code;
        return [NSBundle.mainBundle.infoDictionary[(NSString *)kCFBundleVersionKey] integerValue];
}
+(NSString *)appVersionStr{
    return  (NSString *)NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"];
}


//获取类型的property名字列表,property名字不带_前缀
+(NSArray *)prosWithClz:(Class)clz{
    NSMutableArray *ary=[NSMutableArray array];
    while (clz!=[NSObject class]){
        unsigned int count;
        struct objc_property **pros=class_copyPropertyList(clz, &count);
        for(int i=0;i<count;i++){
            struct objc_property *pro=pros[i];
            [ary addObject:[NSString stringWithUTF8String:property_getName(pro)]];
        }
        clz=[clz superclass];
        free(pros);
    }
    return ary;
}


//获取类型的成员变量名字列表,property的名字前带_前缀
+(NSArray *)varsWithClz:(Class)clz{
    NSMutableArray *ary=[NSMutableArray array];
    unsigned int count;
    Ivar *ivars = class_copyIvarList(clz, &count);
    NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"];
    for(int i=0;i<count;i++){
        Ivar ivar = ivars[i];
        NSString *varname = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if(![filters containsObject:varname]){
            [ary addObject: varname];
        }
    }
    free(ivars);
    Class sclz=[clz superclass];
    if(clz!=[NSObject class]){
        NSArray *ar = [self prosWithClz:sclz];
        [ary addObjectsFromArray:ar];
    }
    return ary;
}


//字典转对象，字典值设置给对象的property字段
+(id)setValues:(NSDictionary *)dict forClz:(Class)clz{
    NSArray *ary=[self prosWithClz:clz];
    id obj=[[clz alloc] init];
    if(nullObj(dict)) return obj;
    for(NSString *key in ary){
        if(dict[key]){
            id val = dict[key];
            [obj setValue:val forKey:key];
        }
    }
    return obj;
}
//字典转对象，字典值设置给对象的成员变量
+(id)setVarValues:(NSDictionary *)dict forClz:(Class)clz{
    NSArray *ary=[self varsWithClz:clz];
    id obj=[[clz alloc] init];
    if(nullObj(dict)) return obj;
    for(NSString *varname in ary){
        NSString *key = [varname hasPrefix:@"_"]?[varname substringFromIndex:1]:varname;
        if(dict[key]){
            id val = dict[key];
            [obj setValue:val forKey:varname];
        }
    }
    return obj;
}

//通过setter方法设置
+(id)setterValues:(NSDictionary *)dict forClz:(Class)clz{
    id obj=[[clz alloc] init];
    if(nullObj(dict)) return obj;
    for(NSString *key in dict.allKeys){
        NSString *fstr = [NSString stringWithFormat:@"set%@%@:",[[key substringToIndex:1] uppercaseString],[key substringFromIndex:1]];
        SEL selector = NSSelectorFromString(fstr);
        if([obj respondsToSelector:selector]){
            [obj setValue:dict[key] forKey:key];
        }
    }
    return obj;
}
//通过setter方法设置
+(void)setterValues:(NSDictionary *)dict forObj:(NSObject *)obj{
    for(NSString *key in dict.allKeys){
        NSString *fstr = [NSString stringWithFormat:@"set%@%@:",[[key substringToIndex:1] uppercaseString],[key substringFromIndex:1]];
        SEL selector = NSSelectorFromString(fstr);
        if([obj respondsToSelector:selector]){
            [obj setValue:dict[key] forKey:key];
        }
    }
}


+(void)setValues:(NSDictionary *)dict forObj:(NSObject *)obj{
    NSArray *ary=[self prosWithClz:obj.class];
    for(NSString *key in ary){
        if(dict[key]){
            [obj setValue:dict[key] forKey:key];
        }
    }
}



+(NSArray *)aryWithClz:(Class)clz fromFile:(NSString *)file{
    NSAssert(file!=0, @"[IUtil aryFromFile:file:] file is nil");
    NSAssert(clz!=0, @"[IUtil aryFromFile:file:] clz is nil");
    NSMutableArray *ary=[NSMutableArray array];
    for(NSDictionary *dict in [NSArray arrayWithContentsOfFile:file]){
        id obj=[[clz alloc] init];
        [obj setValuesForKeysWithDictionary:dict];
        [ary addObject:obj];
    }
    return ary;
}


+(void)postSystemwideNoti:(NSString *)notiname{
    CFNotificationCenterRef distributedCenter =
    CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterPostNotification(distributedCenter, (__bridge CFStringRef)notiname, 0, 0, 1);
}
+(void)observeSystemwideNoti:(NSString *)name cb:(void (^)(void))cb{
    CFNotificationCenterRef distributedCenter =
    CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationSuspensionBehavior behavior =
    CFNotificationSuspensionBehaviorDeliverImmediately;
    CFNotificationCenterAddObserver(distributedCenter,
                                    (void *)(cb),
                            SystemWideNotiCallback,
                                    (__bridge CFStringRef)name,
                                    NULL,
                                    behavior);
}
+(void)removeSystemwideObserver:(id)observer{
    CFNotificationCenterRef distributedCenter =
    CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterRemoveEveryObserver(distributedCenter, (void *)observer);
}

+(void)get:(NSURL *)url cache:(int)cache callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    [[[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:url cachePolicy:cache timeoutInterval:15] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
}

+(void)post:(NSURL *)url body:(NSString *)body callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    
    req.HTTPMethod=@"POST";
  
    req.HTTPBody=[[body stringByRemovingPercentEncoding] dataUsingEncoding:4];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
    
}
//-----upload with data ------
+(void)upload:(NSData *)data name:(NSString *)name
     filename:(NSString *)filename toURL:(NSURL *)url setupReq:(void(^)(NSMutableURLRequest *req))setupReq callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    NSString *boundary=@"--------------1234566";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    if(setupReq)
        setupReq(req);
    req.HTTPMethod=@"POST";
    [req setValue:[@"multipart/form-data; boundary=" stringByAppendingString:boundary] forHTTPHeaderField:@"Content-Type"];
    req.HTTPBody=[self uploadBodyWithBoundary:boundary data:data name:name filename:filename];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
}

+(NSData *)uploadBodyWithBoundary:(NSString *)boundary data:(NSData *)data  name:(NSString *)name filename:(NSString *)filename{
    NSMutableData *mdata=[NSMutableData dataWithData:[self segWithBoundary:boundary data:data name:name filename:filename]];
    [mdata appendData:[self segOfEndingWithBoundary:boundary]];
    return mdata;
    
}

+(NSData *)segWithBoundary:(NSString *)boundary data:(NSData *)data  name:(NSString *)name filename:(NSString *)filename{
    NSMutableData *mdata=[NSMutableData dataWithData:[[NSString stringWithFormat:@"\r\n--%@\r\nContent-Disposition: form-data; name=%@; filename=%@\r\nContent-Type: %@\r\n\r\n",boundary,name,filename,@"application/octet-stream"] dataUsingEncoding:4]];
    [mdata appendData:data];
    return mdata;
}

//-----upload with filepath ------
+(void)uploadFile:(NSString *)file name:(NSString *)name
         filename:(NSString *)filename toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    NSString *boundary=@"--------------1234566";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    
    req.HTTPMethod=@"POST";
    [req setValue:[@"multipart/form-data; boundary=" stringByAppendingString:boundary] forHTTPHeaderField:@"Content-Type"];
    req.HTTPBody=[self uploadBodyWithBoundary:boundary file:file name:name filename:filename];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
}
+(NSData *)uploadBodyWithBoundary:(NSString *)boundary file:(NSString *)file  name:(NSString *)name filename:(NSString *)filename{
    NSMutableData *mdata=[NSMutableData dataWithData:[self segWithBoundary:boundary file:file name:name filename:filename]];
    [mdata appendData:[self segOfEndingWithBoundary:boundary]];
    return mdata;
    
}


//----multi--


+(void)multiUpload:(NSArray *)contents toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback{
    NSString *boundary=@"--------------1234566";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    
    req.HTTPMethod=@"POST";
    [req setValue:[@"multipart/form-data; boundary=" stringByAppendingString:boundary] forHTTPHeaderField:@"Content-Type"];
    req.HTTPBody=[self multiUploadBodyWithBoundary:boundary contents:contents];
    [req.HTTPBody writeToFile:@"/Users/apple/Desktop/con.txt" atomically:YES];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback)
                callback(data,response,error);
        });
        
    }] resume];
}



+(NSData *)multiUploadBodyWithBoundary:(NSString *)boundary contents:(NSArray *)contents{
    NSMutableData *mdata=[NSMutableData data];
    for(int i=0;i<contents.count;i++){
        [mdata appendData:[self segWithBoundary:boundary dict:contents[i]]];
    }
    [mdata appendData:[self segOfEndingWithBoundary:boundary]];
    return mdata;
}


+(NSData *)segWithBoundary:(NSString *)boundary dict:(NSDictionary *)dict{
    if(dict[@"file"]){
        return [self segWithBoundary:boundary file:dict[@"file"] name:dict[@"name"] filename:dict[@"filename"]];
    }else{
        return [self segWithBoundary:boundary name:dict[@"name"] val:dict[@"value"]];
    }
}
+(NSData *)segOfEndingWithBoundary:(NSString *)boundary{
    return [[NSString stringWithFormat:@"\r\n--%@--",boundary ] dataUsingEncoding:4];
}

+(NSData *)segWithBoundary:(NSString *)boundary name:(NSString *)name val:(NSString *)val{
    return [NSData dataWithData:[[NSString stringWithFormat:@"\r\n--%@\r\nContent-Disposition: form-data; name=%@\r\n\r\n%@",boundary,name,val] dataUsingEncoding:4]];
    ;
}

+(NSData *)segWithBoundary:(NSString *)boundary file:(NSString *)file  name:(NSString *)name filename:(NSString *)filename{
    NSURLResponse *resp= [self synResponseByURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",file]]];
    if(!filename)
        filename=[resp suggestedFilename];
    NSMutableData *mdata=[NSMutableData dataWithData:[[NSString stringWithFormat:@"\r\n--%@\r\nContent-Disposition: form-data; name=%@; filename=%@\r\nContent-Type: %@\r\n\r\n",boundary,name,filename,resp.MIMEType] dataUsingEncoding:4]];
    ;
    
    [mdata appendData:[NSData dataWithContentsOfFile:file]];
    ;
    return mdata;
}


+(NSURLResponse *)synResponseByURL:(NSURL *)url{
    NSURLResponse *respon;
    [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:&respon error:0];
    return respon;
}

//----multi--

















//CUP & MEMORY
+ (NSInteger)availableMemory

{
    
    vm_statistics_data_t vmStats;
    
    mach_msg_type_number_t infoCount =HOST_VM_INFO_COUNT;
    
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               
                                               HOST_VM_INFO,
                                               
                                               (host_info_t)&vmStats,
                                               
                                               &infoCount);
    
    
    
    if (kernReturn != KERN_SUCCESS) {
        
        return NSNotFound;
        
    }
    
    
    
    return (vm_page_size *vmStats.free_count) ;
    
}

+ (NSInteger)usedMemory

{
    
    task_basic_info_data_t taskInfo;
    
    mach_msg_type_number_t infoCount =TASK_BASIC_INFO_COUNT;
    
    kern_return_t kernReturn =task_info(mach_task_self(),
                                        
                                        TASK_BASIC_INFO,
                                        
                                        (task_info_t)&taskInfo,
                                        
                                        &infoCount);
    
    
    
    if (kernReturn != KERN_SUCCESS
        
        ) {
        
        return NSNotFound;
        
    }
    
    
    
    return taskInfo.resident_size ;
    
}

+(double)curUsage{
    return [self usedMemory]*100.0/[self GetMemoryStatistics];
}


+(NSString *)deviceUUId{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}




+ (NSInteger)GetMemoryStatistics {
    
    // Get Page Size
    int mib[2];
    unsigned long page_size;
    size_t len;
    
    mib[0] = CTL_HW;
    mib[1] = HW_PAGESIZE;
    len = sizeof(page_size);
    
    //    // 方法一: 16384
    //    int status = sysctl(mib, 2, &page_size, &len, NULL, 0);
    //    if (status < 0) {
    //        perror("Failed to get page size");
    //    }
    //    // 方法二: 16384
    //    page_size = getpagesize();
    // 方法三: 4096
    if( host_page_size(mach_host_self(), (vm_size_t *)&page_size)!= KERN_SUCCESS ){
        perror("Failed to get page size");
    }
    printf("Page size is %ld bytes\n", page_size);
    
    // Get Memory Size
    mib[0] = CTL_HW;
    mib[1] = HW_MEMSIZE;
    long ram;
    len = sizeof(ram);
    if (sysctl(mib, 2, &ram, &len, NULL, 0)) {
        perror("Failed to get ram size");
    }
    printf("Ram size is %f MB\n", ram / (1024.0) / (1024.0));
    
    // Get Memory Statistics
    //    vm_statistics_data_t vm_stats;
    //    mach_msg_type_number_t info_count = HOST_VM_INFO_COUNT;
    vm_statistics64_data_t vm_stats;
    mach_msg_type_number_t info_count64 = HOST_VM_INFO64_COUNT;
    //    kern_return_t kern_return = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm_stats, &info_count);
    kern_return_t kern_return = host_statistics64(mach_host_self(), HOST_VM_INFO64, (host_info64_t)&vm_stats, &info_count64);
    if (kern_return != KERN_SUCCESS) {
        printf("Failed to get VM statistics!");
    }
    
    double vm_total = vm_stats.wire_count + vm_stats.active_count + vm_stats.inactive_count + vm_stats.free_count;
    return vm_total;
//    double vm_wire = vm_stats.wire_count;
//    double vm_active = vm_stats.active_count;
//    double vm_inactive = vm_stats.inactive_count;
//    double vm_free = vm_stats.free_count;
//    double unit = (1024.0) * (1024.0);
    
//    NSLog(@"Total Memory: %f", vm_total * page_size / unit);
//    NSLog(@"Wired Memory: %f", vm_wire * page_size / unit);
//    NSLog(@"Active Memory: %f", vm_active * page_size / unit);
//    NSLog(@"Inactive Memory: %f", vm_inactive * page_size / unit);
//    NSLog(@"Free Memory: %f", vm_free * page_size / unit);

}



+(double)GetCpuUsage {
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    if (thread_count > 0)
        stat_thread += thread_count;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return 0;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    return tot_cpu;
    
//    NSLog(@"CPU Usage: %f \n", tot_cpu);
}




#pragma mark - from cate


NSTimer * iTimer(CGFloat inteval,id tar,SEL sel,id userinfo){
    NSTimer *timer=[NSTimer timerWithTimeInterval:inteval target:tar selector:sel userInfo:userinfo repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

CADisplayLink *iDLink(id tar,SEL sel){
    CADisplayLink *link= [CADisplayLink displayLinkWithTarget:tar selector:sel];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return link;
}

void runOnMain(void (^blo)(void)){
    dispatch_async(dispatch_get_main_queue(), blo);
}
void runOnGlobal(void (^blo)(void)){
    dispatch_async(dispatch_get_global_queue(0, 0), blo);
}



NSString * iphoneType() {
    
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
    
}



NSLocale * prefLocale(){
    return [NSLocale localeWithLocaleIdentifier:[NSLocale preferredLanguages][0]];
//    [NSLocale localeWithLocaleIdentifier:[NSBundle mainBundle].preferredLocalizations.firstObject];
}
NSString * localeLanguage(){
    return [prefLocale() objectForKey:NSLocaleLanguageCode];
}
NSString * localeCountry(){
    return [prefLocale() objectForKey:NSLocaleCountryCode];
}

//时差，单位秒
NSInteger  timeOffset(void){
    return [NSTimeZone systemTimeZone].secondsFromGMT;
}


BOOL isRightToLeft(){
    return [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:UIView.appearance.semanticContentAttribute]==UIUserInterfaceLayoutDirectionRightToLeft;
}

@end
