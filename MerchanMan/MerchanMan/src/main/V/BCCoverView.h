//
//  BCCoverView.h
//  BatteryCam
//
//  Created by yf on 2018/3/16.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCCoverView : UIView
+(void)showAt:(UIView *)view;
-(void)showAt:(UIView *)view;
-(void)dismiss;
@property (nonatomic,strong)UIView *mask;
@end
