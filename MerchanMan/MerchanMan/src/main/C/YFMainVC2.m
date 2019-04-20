
//

#import "YFMainVC2.h"
#import "YFMerchanListVC.h"
#import "YFMainNav.h"
#import "BCLeftMenuVC.h"
#import "BCCoverView.h"

@interface YFMainVC2 ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)YFMainNav *curVC;
@property (nonatomic,strong)BCLeftMenuVC *menuVC;
@property (nonatomic,strong)BCCoverView *blurMask;

@end

@implementation YFMainVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    //CurVC
    YFMerchanListVC *govc =[[YFMerchanListVC alloc] init];
    self.curVC=[[YFMainNav alloc] initWithRootViewController:govc];
    [self.view addSubview:self.curVC.view];
    [self.curVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    //menuVC
    self.menuVC=[[BCLeftMenuVC alloc] init];
    [self.view addSubview:self.menuVC.view];
    self.menuVC.view.layer.shadowColor=[[UIColor blackColor]CGColor];
    self.menuVC.view.layer.shadowOffset=(CGSize){-2,4};
    self.menuVC.view.layer.shadowRadius=10;
    self.menuVC.view.layer.shadowOpacity=.2;
    [self setMenuVC2InitState];
    [self.menuVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(@0);
        make.width.equalTo(@(self.menuVC.preferredContentSize.width));
        make.bottom.equalTo(@(0));
    }];
    
    //blurMask
    self.blurMask=[[BCCoverView alloc]init];
    //    self.blurMask.blurRadius=2;
    self.blurMask.mask.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.7];
    
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan2:)];
    pan.delegate=self;
    [self.view addGestureRecognizer:pan];
    
}

-(void)onPan2:(UIPanGestureRecognizer *)pan{
    static CGFloat scale;
    static CGFloat maxx;
    static CGAffineTransform dest;
    static CGAffineTransform dest2;
    static CGFloat maxXAddition=0;
    static long l=0;
    
    static CGFloat alpha = 0;
    static CGAffineTransform menuVCdest;
    static CGFloat menuscale;
    static CGFloat menumaxx;
    dispatch_once(&l, ^{
        scale=(iScreenH-ScaleTopMargin*2)/iScreenH;
        maxx=iScreenW-iScreenW*vScaleRight;
        dest=CGAffineTransformTranslate(CGAffineTransformMakeScale(scale, scale), (maxx-(iScreenW*(1-scale)*.5))/scale, 0);
        dest2=CGAffineTransformTranslate(CGAffineTransformMakeScale(scale, scale), (maxx+maxXAddition-(iScreenW*(1-scale)*.5))/scale, 0);
        
        menuscale=scale;
        menumaxx=-self.menuVC.preferredContentSize.width;
        menuVCdest=CGAffineTransformTranslate(CGAffineTransformMakeScale(menuscale, menuscale), (menumaxx-(iScreenW*(1-menuscale)*.5))/menuscale, 0);
    }) ;
    
    static CGFloat lastx=0;
    
    UIView *view=self.curVC.view;
    UIView *menuView = self.menuVC.view;
    if(pan.state==UIGestureRecognizerStateBegan){
        lastx=0;
        if(!self.blurMask.superview)
            [self.blurMask showAt:self.curVC.view];
    }
    CGFloat x=[pan translationInView:self.view].x;
    CGFloat delta=x-lastx;
    lastx=x;
    
    CGFloat nowx=view.x+delta;
    if(nowx<=0){
        view.transform=CGAffineTransformIdentity;
        [self setMenuVC2InitState];
    }else if(nowx>=maxx+maxXAddition){
        view.transform=dest2;
        menuView.transform=CGAffineTransformIdentity;
        menuView.alpha=1;
    }else{
        CGFloat donePercent =nowx/maxx;
        CGFloat xyscale=1-(donePercent*(1-scale));
        view.transform=CGAffineTransformTranslate(CGAffineTransformMakeScale(xyscale, xyscale),(nowx-(iScreenW*(1-xyscale)*.5))/xyscale, 0);
        
        CGFloat menuxyscale=1-((1-donePercent)*(1-menuscale));
        CGFloat menutranslatex=menumaxx*(1-donePercent);
        menuView.transform=CGAffineTransformTranslate(CGAffineTransformMakeScale(menuxyscale, menuxyscale), (menutranslatex-(iScreenW*(1-menuxyscale)*.5))/menuscale, 0);
        menuView.alpha=(donePercent)*(1-alpha);
        
    }
    
    if(pan.state==UIGestureRecognizerStateEnded||pan.state==UIGestureRecognizerStateFailed||pan.state==UIGestureRecognizerStateCancelled){
        
        CGFloat totaldura=.4;
        CGFloat rest=maxx-nowx;
        if(rest<0) rest=-rest;
        CGFloat dura=rest/maxx*totaldura;
        if(nowx>maxx*.5){
            //            if(dura<.1)dura=.1;
            [UIView animateWithDuration:dura delay:0 usingSpringWithDamping:1 initialSpringVelocity:.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                view.transform=dest;
                menuView.alpha=1;
                menuView.transform=CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [self setIsScale:YES];
                [self leftClick:NO];
            }];
        }else{
            dura=totaldura-dura;
            //            if(dura<.1) dura=.1;
            [UIView animateWithDuration:dura delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                view.transform=CGAffineTransformIdentity;
                [self setMenuVC2InitState];
            } completion:^(BOOL finished) {
                self.isScale=NO;
                [self coverClick:NO];
            }];
        }
    }
    
}



-(void)leftClick:(BOOL)animated{
    if(!self.blurMask.superview)
        [self.blurMask showAt:self.curVC.view];
    static CGFloat scale;
    static CGFloat maxx;
    static CGAffineTransform dest;
    static long l=0;
    dispatch_once(&l, ^{
        scale=(iScreenH-ScaleTopMargin*2)/iScreenH;
        maxx=iScreenW-iScreenW*vScaleRight;
        dest=CGAffineTransformTranslate(CGAffineTransformMakeScale(scale, scale), (maxx-(iScreenW*(1-scale)*.5))/scale, 0);
    });
    
    
    [self.cover removeFromSuperview];
    _cover=[[UIButton alloc]initWithFrame:self.curVC.view.bounds];
    [_cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.curVC.view addSubview:_cover];
    
    
    CGFloat dura = animated?.4:0;
    [UIView animateWithDuration:dura delay:0 usingSpringWithDamping:1 initialSpringVelocity:.7 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.curVC.view.transform=dest;
        self.menuVC.view.transform=CGAffineTransformIdentity;
        self.menuVC.view.alpha=1;
    } completion:^(BOOL finished) {
        self.isScale=YES;
    }];
    
    
}
-(void)coverClick{
    [self coverClick:YES];
}
-(void)coverClick:(BOOL)animated{
    [self.blurMask dismiss];
    
    CGFloat dura = animated?.25:0;
    [UIView animateWithDuration:dura delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.curVC.view.transform=CGAffineTransformIdentity;
        [self setMenuVC2InitState];
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
        self.cover=nil;
        self.isScale=NO;
        if(self.onCoverRm)
            self.onCoverRm();
    }];
}

-(void)setMenuVC2InitState{
    static CGAffineTransform menuVCdest;
    static long l=0;
    static CGFloat alpha = 0;
    dispatch_once(&l, ^{
        CGFloat scale=(iScreenH-ScaleTopMargin*2)/iScreenH;
        CGFloat maxx=-self.menuVC.preferredContentSize.width;
        menuVCdest=CGAffineTransformTranslate(CGAffineTransformMakeScale(scale, scale), (maxx-(iScreenW*(1-scale)*.5))/scale, 0);
    });
    self.menuVC.view.transform=menuVCdest;
    self.menuVC.view.alpha=alpha;
    [self.menuVC stateChange];
}






#pragma mark - delegates
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //全部禁止右滑手势
    return  NO;
#if(0)
    // 如果是在第一个vc界面，并且水平位置小于80，并且水平速度大于0则返回YES；
    BOOL b = (self.curVC.topViewController==[self.curVC.viewControllers firstObject])
    &&(self.isScale||[gestureRecognizer locationInView:self.view].x<dp2po(100));
    
    if(!b) return b;
    UIPanGestureRecognizer * gest = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint p = [gest velocityInView:self.view];
    return p.x>0||_isScale;
#endif
}




#pragma mark - Ratation and Orientation

-(BOOL)shouldAutorotate {
    return self.curVC.shouldAutorotate;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.curVC preferredInterfaceOrientationForPresentation];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.curVC supportedInterfaceOrientations];
}


-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.curVC;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.curVC  willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}
@end









