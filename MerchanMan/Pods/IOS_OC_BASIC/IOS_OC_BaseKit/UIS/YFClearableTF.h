//
//  YFClearableTF.h
//  BatteryCam
//
//  Created by yf on 2017/8/18.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFClearableTF : UITextField
@property (nonatomic,strong)void (^onTxtChangeCB)(YFClearableTF *);
@end
