//
//  BCUserInfoCell.h
//  BatteryCam
//
//  Created by yf on 2017/8/8.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCUserInfoCell : UITableViewCell
@property (nonatomic,copy)void (^cb)(void);
-(void)updateUserInfo;
@end
