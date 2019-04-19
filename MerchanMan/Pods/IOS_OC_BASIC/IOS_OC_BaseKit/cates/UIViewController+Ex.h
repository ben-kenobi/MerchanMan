//
//  UIViewController+Ex.h
//Created by apple on 17/07/21.
//

#import <UIKit/UIKit.h>
#define iVCKey "curVC"
@interface UIViewController (Ex)
+(void)pushVC:(UIViewController *)vc;
+(void)popVC;
+(void)setVC:(UIViewController *)vc;
+(instancetype)curVC;
-(void)alert:(NSString *)title msg:(NSString *)msg;
+(UIViewController *)topVC;
@end
