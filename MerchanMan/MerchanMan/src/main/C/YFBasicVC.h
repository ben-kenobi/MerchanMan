

#import <UIKit/UIKit.h>

@interface YFBasicVC : UIViewController
{
    __weak UINavigationController *_nav;
}
@property (nonatomic,assign)BOOL ignoreAddToCurVC;
@property (nonatomic,assign)BOOL ignoreForeground;
@property (nonatomic,assign)BOOL isForeground;
@property (nonatomic,assign)BOOL fullScreen;//表示是否显示为全屏样式，banner则需要放到界面顶端(一般为顶部导航栏为全透明)

-(void)setNavigationController:(UINavigationController *)nav;//VC作为其他VC的View使用时，需要给他指定nav



#pragma mark - optional override by subclass ,need super
-(void)onWifiEnable;
-(void)onCellullarEnable;
-(void)onNetworkDisable;
-(CGRect)newGuideFrame;

@end
