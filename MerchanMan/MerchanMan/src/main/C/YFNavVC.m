
#import "YFNavVC.h"

@implementation YFNavVC

-(void)viewDidLoad{
    [super viewDidLoad];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    UIBarButtonItem *item =
    [[UIBarButtonItem alloc] initWithTitle:@"" style:0 target:0 action:0];;
    [item setTitleTextAttributes:@{NSFontAttributeName:iFont(15)} forState:UIControlStateNormal];
    viewController.navigationItem.backBarButtonItem=item;
    
    
    if(self.childViewControllers.count>0)
        viewController.hidesBottomBarWhenPushed=YES;
    [super pushViewController:viewController animated:animated];
    
    //只有调用根控制器的方法才能改变statusbar的状态
    [iAppDele.window.rootViewController setNeedsStatusBarAppearanceUpdate];
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc=[super popViewControllerAnimated:animated];
    [iAppDele.window.rootViewController setNeedsStatusBarAppearanceUpdate];
    return vc;
}

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


#pragma mark - Ratation and Orientation

-(BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}
@end
