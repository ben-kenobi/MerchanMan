//
//  YFNoHitWin.h
//  IOS_OC_BASIC
//
//  Created by yf on 2018/12/18.
//  Copyright © 2018 yf. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YFNoHitWin : UIWindow
+(instancetype)winWithRootVC:(UIViewController *)rootVC;


/**
 操作回调的View进行视图添加
 */
+(instancetype)winWithCreateCB:(void (^)(UIView *view))cb;
@end

