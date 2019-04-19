//
//  BCAlertStylesheetVC.h
//  BatteryCam
//
//  Created by yf on 2017/8/16.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCStyleSheetMod.h"
@interface BCAlertStylesheetVC : UIViewController
@property (nonatomic,strong)id<BCStyleSheetListDelegate> datas;
@property (nonatomic,copy)void (^dismissCB)(void) ;
@end
