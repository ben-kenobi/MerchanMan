
#import "YFBasicVC.h"
#import "objc/runtime.h"

#import "YFMsgBanner.h"
#import "BCRechabilityVM.h"


@interface YFBasicVC()
@end


@implementation YFBasicVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
//    [self registerNetworkObservers];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIUtil commonNav:self shadow:NO line:YES translucent:NO];
    if(!self.ignoreAddToCurVC)
        [UIViewController setVC:self];
    if(!self.ignoreForeground)
        self.isForeground=YES;
    [self.navigationController setNavigationBarHidden:self.fullScreen animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isForeground=NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view endEditing:YES];
    [BCRechabilityVM checkNetworkStatus];
    //----- Firebase
//    [FIRAnalytics setScreenName:self.title screenClass:[self.classForCoder description]];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}



-(void)setNavigationController:(UINavigationController *)nav{
    _nav=nav;
}
-(UINavigationController *)navigationController{
    if(_nav)return _nav;
    return [super navigationController];
}



#pragma mark - network
-(void)registerNetworkObservers{
    [iNotiCenter addObserver:self selector:@selector(onWifiEnable) name:BC_NETWORK_WIFI object:nil];
    [iNotiCenter addObserver:self selector:@selector(onCellullarEnable) name:BC_NETWORK_WWAN object:nil];
    [iNotiCenter addObserver:self selector:@selector(onNetworkDisable) name:BC_NETWORK_NONE object:nil];
}
-(void)onWifiEnable{
    [self onNetworkEnable];
}
-(void)onCellullarEnable{
    [self onNetworkEnable];
}

-(void)onNetworkDisable{
    if(self.isForeground)
        [self showBannerMsg:NSLocalizedString(@"bc.devices.not_to_internet",0) with:iFormatStr(@"neworkToast_%ld",self.hash)];
}



-(void)onNetworkEnable{
    [self dismissBanner:iFormatStr(@"neworkToast_%ld",self.hash)];
}


#pragma mark - newguide
-(CGRect)newGuideFrame{
    return CGRectZero;
}

#pragma mark - Utils
-(void)showBannerMsg:(NSString *)msg with:(NSString *)iden{
    [YFMsgBanner showAt:self.view withCountdown:-1 msg:msg iden:iden color:iInfoTipColor  icon:img(@"disconnect_network_icon") fullScreen:self.fullScreen];
}

-(void)dismissBanner:(NSString *)iden{
    [YFMsgBanner dismiss:iden];
}





#pragma mark - ratation
-(BOOL)shouldAutorotate {
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskPortrait;
    return mask;
}






@end
