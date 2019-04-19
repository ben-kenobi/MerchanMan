//
//  YFFloatWindow.h
//  BatteryCam
//
//  Created by yf on 2017/12/22.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFFloatWindow : UIWindow
@property (nonatomic,assign)BOOL show;
@property (nonatomic,assign)UIInterfaceOrientation orientation;
-(id)initWith:(BOOL)hor;
@end
