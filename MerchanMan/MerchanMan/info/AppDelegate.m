//
//  AppDelegate.m
//Created by apple on 17/07/21.

//
#import "AppDelegate.h"
#import "YFCate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc] initWithFrame:iScreen.bounds];
    [self setRootVC];
    [self setNavigationBarStyle];
    [self.window setBackgroundColor:[UIColor whiteColor]];

    [self.window makeKeyAndVisible];
    return YES;
}



#pragma mark - setupRootVC
-(void)setRootVC{
    if(!self.window)return;
    self.window.rootViewController=[self setupMainVC];
}

-(UIViewController *)setupMainVC{
    self.mainVC =[[NSClassFromString(iRes4dict(@"conf.plist")[@"rootVC"]) alloc] init];
    return self.mainVC;
}







- (void)setNavigationBarStyle
{
    
    [iApp setStatusBarStyle:UIStatusBarStyleDefault];
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.shadowImage=[UIImage img4Color:iColor(0xe6, 0xe6, 0xe6, 1)];
    bar.barTintColor =[UIColor whiteColor];
    [bar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    bar.tintColor = iColor(0x44, 0x44, 0x44, 1);
    bar.translucent=NO;
    
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : iColor(0x11, 0x11, 0x11, 1),NSFontAttributeName:iFont(18)}];
}
























- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   UIBackgroundTaskIdentifier taskID=[application beginBackgroundTaskWithExpirationHandler:^{
       
   }];
    if(taskID != UIBackgroundTaskInvalid){
        [iApp endBackgroundTask:taskID];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
}




@end
