//
//  BCQRCodeScanView.h
//  BatteryCam
//
//  Created by yf on 2018/11/15.
//  Copyright © 2018 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCQRCodeScanView : UIView
@property (nonatomic,copy)void (^scanResultCB)(NSString *result);

@property (nonatomic,assign)BOOL running;
-(BOOL)flashLight;
@end

NS_ASSUME_NONNULL_END
