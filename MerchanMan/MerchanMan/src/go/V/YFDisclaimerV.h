//
//  BCDisclaimerV.h
//  BatteryCam
//
//  Created by yf on 2017/10/26.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ProtocolActionBlock)(NSInteger protocolType);

@interface YFDisclaimerV : UITextView

@property(nonatomic,copy)ProtocolActionBlock protocolActionBlock;

-(instancetype)initWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment action:(ProtocolActionBlock)block;

@end
