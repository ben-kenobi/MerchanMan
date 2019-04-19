//
//  UIViewController+Ex.m
//Created by apple on 17/07/21.
//

#import "UIViewController+Ex.h"
#import "objc/runtime.h"
#import "YFCate.h"



@implementation UIViewController (Ex)

+(void)pushVC:(UIViewController *)vc{
//   id obj= [objc_getAssociatedObject(iApp, iVCKey) navigationController];
    runOnMain(^{
        UIViewController * obj=self.curVC;
        if(obj.navigationController){
            [obj.navigationController showViewController:vc sender:nil];
        }else{
            [obj showViewController:vc sender:nil];
        }
        //        if([obj  isKindOfClass:[UINavigationController class]]){
        ////            [(UINavigationController *)obj pushViewController:vc animated:YES];
        //            [(UINavigationController *)obj showViewController:vc sender:0];
        //        }else{
        //            [[obj navigationController] showViewController:vc sender:nil];
        ////            [[obj navigationController] pushViewController:vc animated:YES];
        //        }

    });
}

+(void)setVC:(UIViewController *)vc{
    YFWeakRef *ref = [YFWeakRef refWith:vc];
    objc_setAssociatedObject(mainApp(), iVCKey, ref, OBJC_ASSOCIATION_RETAIN);
}

+(void)popVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *obj=[self curVC];
        if([obj  isKindOfClass:[UINavigationController class]]){
            [(UINavigationController *)obj popViewControllerAnimated:YES];
        }else{
            [ [obj navigationController] popViewControllerAnimated:YES];
        }
    });
}

+(instancetype)curVC{
   return  ((YFWeakRef*)(objc_getAssociatedObject(mainApp(), iVCKey))).obj;
}

-(void)alert:(NSString *)title msg:(NSString *)msg{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [vc addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:0]];
    [self presentViewController:vc animated:YES completion:nil];
}


+(UIViewController *)topVC{

    UIWindow *window = [mainApp().delegate window];
    UIViewController *topViewController = [window rootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;

}
@end
