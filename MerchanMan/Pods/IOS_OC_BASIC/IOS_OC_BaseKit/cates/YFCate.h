

#import "UIView+Ex.h"
#import "UIColor+Ex.h"
#import "UIImage+Ex.h"
#import "NSString+Ex.h"
#import "NSArray+Ex.h"
#import "IUtil.h"
#import "UIViewController+Ex.h"
#import <Masonry/Masonry.h>
#import "NSDate+Ex.h"
#import "NSObject+Ex.h"
#import "FileUtil.h"
#import "NetUtil.h"
#import "UIImageView+WEB.h"
#import "UIButton+Ex.h"
#import "UIBarButtonItem+Ex.h"
#import <AFNetworking/AFNetworking.h>
#import "UIUtil.h"
#import "IProUtil.h"
#import <UIKit/UIKit.h>
#import "YFConst.h"
#import "YFAVUtil.h"
#import "YFWeakRef.h"


#ifdef __cplusplus
extern "C" {
#endif
typedef void (^defBlock)(void);

UIWindow *frontestWindow(void);
UIImage * i18nImg(NSString *name);
void myCleanupBlock(__strong void(^*block)(void));

#ifdef __cplusplus
}
#endif

@interface iDialog : NSObject
+(void)dialogWith:(NSString*)title msg:(NSString*)msg actions:(NSArray *)actions vc:(UIViewController*)vc;
@end



