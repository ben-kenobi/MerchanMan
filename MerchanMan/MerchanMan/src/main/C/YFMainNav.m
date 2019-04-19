
#import "YFMainNav.h"


@interface YFMainNav ()<UIGestureRecognizerDelegate>


@end

@implementation YFMainNav

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate=self;
    self.interactivePopGestureRecognizer.enabled=YES;
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return [self.viewControllers count] > 1;
    }
    return YES;
}


@end
