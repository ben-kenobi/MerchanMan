//
//  IUtil.h
//Created by apple on 17/07/21.
//

#import <UIKit/UIKit.h>


#ifndef weakRef
#if DEBUG
#if __has_feature(objc_arc)
#define weakRef(object) autoreleasepool{} __weak __typeof__(object) weak_##object = object;
#else
#define weakRef(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakRef(object) try{} @finally{} {} __weak __typeof__(object) weak_##object = object;
#else
#define weakRef(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif




#define iScreen \
[UIScreen mainScreen]
#define iScreenW iScreen.bounds.size.width
#define iScreenH iScreen.bounds.size.height
#define iBundle [NSBundle mainBundle]


#define iPref(name)[[NSUserDefaults alloc] initWithSuiteName:(name)]

#define iApp [UIApplication sharedApplication]
#define iAppDele ((AppDelegate *)[iApp delegate])

#define iFm  [NSFileManager defaultManager]
#define iRes(res)  [[NSBundle mainBundle]pathForResource:(res) ofType:0]

#define  iRes4dict(res)  [NSDictionary dictionaryWithContentsOfFile:iRes(res)]

#define iRes4ary(res) [NSArray arrayWithContentsOfFile:iRes(res)]

#define iURL(name) [NSURL URLWithString:(name)]
#define iFURL(name) [NSURL fileURLWithPath:(name)]

#define iData(name) [NSData dataWithContentsOfURL:iURL(name)]

#define iData4F(name) [NSData dataWithContentsOfFile:(name)]

#define imgFromData(name) [UIImage imageWithData:iData(name)]

#define imgFromData4F(name) [UIImage imageWithData:iData4F(name)]

#define imgFromF(name) [UIImage imageWithContentsOfFile:(name)]

#define img(name) [UIImage imageNamed:(name)]
#define iStr(key) NSLocalizedString((key),0)

#define iNotiCenter [NSNotificationCenter defaultCenter]
#define iMainQueue [NSOperationQueue mainQueue]
#define iEmptyStr(str) (!(str)||[(str) isEqualToString:@""])


#define iVersion [[[UIDevice currentDevice]systemVersion]floatValue]


#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))


#define iLazy4Dict(na1,na2) -(NSMutableDictionary *)na1{\
if(!na2){\
na2=[NSMutableDictionary  dictionary];\
}\
return na2;\
}

#define iLazy4Ary(na1,na2) -(NSMutableArray *)na1{\
if(!na2){\
na2=[NSMutableArray  array];\
}\
return na2;\
}
#define iColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define iGlobalBG iColor(246,246,246,1)
#define iGlobalBG2 iColor(0xfc,0xfc,0xfc,1)
#define iCommonSeparatorColor iColor(0xe8,0xe8,0xe8,1)
#define iGlobalOrange iColor(0xff,0x73,0x0a,1)

#define iSwitchTint iGlobalFocusColor
//#define iSwitchTint iColor(0x40,0xda,0x6c,1)


//#define iGlobalFocusColor iColor(0x2D, 0xc8, 0xff, 1)
//#define iGlobalFocusColor iColor(0x00, 0xD2, 0xc3, 1)
#define iGlobalFocusColor iColor(0x2b, 0x92, 0xf9, 1)
#define iGlobalHLFocusColor iColor(40, 138, 237, 1)
#define iGlobalDisableColor iColor(0xdc, 0xe1, 0xe6, 1)
#define iGlobalErrorColor iColor(0xff, 0x4f, 0x4f, 1)


//#define iDarkBG iColor(0x20, 0x1f, 0x1f, 1)
#define iDarkBG iColor(0xff, 0xff, 0xff, 1)


#define iFont(size) [UIFont systemFontOfSize:(size)]
#define iBFont(size) [UIFont boldSystemFontOfSize:(size)]



#define iFormatStr(...) ([NSString stringWithFormat:__VA_ARGS__])

#define iStBH 20
#define iNavH 44
#define iTopBarH (iStBH+iNavH)
#define iTabBarH 49
#define framePerSecond 15

#ifdef DEBUG
#define iLog(...) NSLog(__VA_ARGS__)

#define iBaseURL @"http://"

#else
#define iLog(...)

#define iBaseURL @"http://"

#endif



#define iCommonLog(desc) \
iLog(@"\nfile：%@\nline：%d\nmethod：%s\ndesc：%@", [NSString stringWithUTF8String:__FILE__], __LINE__,  __FUNCTION__, desc);
#define iCommonLog2(desc)\
iLog(@"\nclass:%@\nline:%d\ndesc:%@",[self class],__LINE__,desc);




#define onExit \
__strong void(^block)(void) __attribute__((cleanup(myCleanupBlock), unused)) = ^















#define LoginNoti @"LoginNoti"
#define LogoutNoti @"LogoutNoti"
#define usernamekey @"usernamekey"
#define pwdkey @"pwdkey"


#ifdef __cplusplus
extern "C" {
#endif
typedef enum : NSUInteger {
    BCHttpMethodGet,
    BCHttpMethodPost,
    BCHttpMethodPostJson,
    BCHttpMethodDelete,
    BCHttpMethodPut
} BCHttpMethod;

typedef void(^iBaseBlock)(void);

id nilID(void);
UIApplication *mainApp(void);
CGFloat dp2po(CGFloat dp);
int scale(void);
NSString *scaledImgName(NSString * name,NSString *ext);
BOOL emptyStr(NSString *str);
BOOL nullObj(id obj);

    
#pragma mark - from cate
    
NSLocale * prefLocale(void);
NSString * localeLanguage(void);
NSString * localeCountry(void);
NSInteger  timeOffset(void);//时差，单位秒

NSTimer * iTimer(CGFloat inteval,id tar,SEL sel,id userinfo);

CADisplayLink *iDLink(id tar,SEL sel);
void runOnMain(void (^blo)(void));
void runOnGlobal(void (^blo)(void));

NSString * iphoneType(void) ;
BOOL isRightToLeft(void);

    
#ifdef __cplusplus
}
#endif
    
@interface IUtil : NSObject
+(NSString *)getTimestamp;
+(void)broadcast:(NSString *)mes info:(NSDictionary *)info;
+(float)systemVersion;
+(NSInteger)appVersion;
+(NSString *)appVersionStr;

+(NSArray *)prosWithClz:(Class)clz;
+(NSArray *)varsWithClz:(Class)clz;
+(id)setValues:(NSDictionary *)dict forClz:(Class)clz;
//通过setter方法设置
+(id)setterValues:(NSDictionary *)dict forClz:(Class)clz;
//通过setter方法设置
+(void)setterValues:(NSDictionary *)dict forObj:(NSObject *)obj;
+(void)setValues:(NSDictionary *)dict forObj:(NSObject *)obj;

+(NSArray *)aryWithClz:(Class)clz fromFile:(NSString *)file;


+(void)postSystemwideNoti:(NSString *)notiname;


/**
 添加系统级的广播监听
 @param name 广播名
 @param cb 回调，需要外部保持强引用，并且需要在不需要的时候 removeSystemwideObserver
 */
+(void)observeSystemwideNoti:(NSString *)name cb:(void (^)(void))cb;
+(void)removeSystemwideObserver:(id)observer;

+(NSData *)uploadBodyWithBoundary:(NSString *)boundary file:(NSString *)file  name:(NSString *)name filename:(NSString *)filename;
+(NSURLResponse *)synResponseByURL:(NSURL *)url;

+(void)uploadFile:(NSString *)file name:(NSString *)name
         filename:(NSString *)filename toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;
+(void)upload:(NSData *)data name:(NSString *)name
     filename:(NSString *)filename toURL:(NSURL *)url setupReq:(void(^)(NSMutableURLRequest *req))setupReq callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;

+(void)multiUpload:(NSArray *)contents toURL:(NSURL *)url callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;


+(void)post:(NSURL *)url body:(NSString *)body callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;
+(void)get:(NSURL *)url cache:(int)cache callBack:(void (^)(NSData *data,NSURLResponse *response, NSError *error))callback;



+ (NSInteger)availableMemory;

+ (NSInteger)usedMemory;
+ (double)curUsage;
+(double)GetCpuUsage ;
+ (NSInteger)GetMemoryStatistics ;
+(NSString *)deviceUUId;

@end

