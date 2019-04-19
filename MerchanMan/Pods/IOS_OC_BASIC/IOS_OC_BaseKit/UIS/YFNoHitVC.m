

//
//  YFNoHitVC.m
//  IOS_OC_BASIC
//
//  Created by yf on 2018/12/18.
//  Copyright © 2018 yf. All rights reserved.
//

#import "YFNoHitVC.h"
#import "YFNoHitView.h"
#import "YFCate.h"


@implementation YFNoHitVC

-(void)loadView{
    self.view = [[YFNoHitView alloc]init];
}


#pragma mark - ratation
-(BOOL)shouldAutorotate {
    return UIViewController.topVC.shouldAutorotate;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIViewController.topVC.supportedInterfaceOrientations;
    
}

@end
