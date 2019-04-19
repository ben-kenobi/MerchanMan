
//
//  BCUIAlertVC.m
//  BatteryCam
//
//  Created by yf on 2017/10/26.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCUIAlertVC.h"



@interface BCUIAlertVC ()<UIViewControllerTransitioningDelegate>
@property(nonatomic,weak)id<UIViewControllerTransitioningDelegate> srcDelegate;
@end

@implementation BCUIAlertVC
#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
     if([self.srcDelegate respondsToSelector:@selector(animationControllerForPresentedController:presentingController:sourceController:)])
         return [self.srcDelegate animationControllerForPresentedController:presented presentingController:presenting sourceController:source];
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    if(self.dismissCB)
        self.dismissCB();
     if([self.srcDelegate respondsToSelector:@selector(animationControllerForDismissedController:)])
         return [self.srcDelegate animationControllerForDismissedController:dismissed];
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
     if([self.srcDelegate respondsToSelector:@selector(interactionControllerForPresentation:)])
         return [self.srcDelegate interactionControllerForPresentation:animator];
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    if([self.srcDelegate respondsToSelector:@selector(interactionControllerForDismissal:)])
        return [self.srcDelegate interactionControllerForDismissal:animator];
    return nil;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
    if([self.srcDelegate respondsToSelector:@selector(presentationControllerForPresentedViewController:presentingViewController:sourceViewController:)])
        return [self.srcDelegate presentationControllerForPresentedViewController:presented presentingViewController:presenting sourceViewController:source];
    return nil;
}


#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(instancetype)init{
    if(self = [super init]){
        self.srcDelegate=self.transitioningDelegate;
        self.transitioningDelegate=self;
    }
    return self;
}



@end
