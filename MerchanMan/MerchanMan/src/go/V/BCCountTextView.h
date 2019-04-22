//
//  BCCountTextView.h
//  BatteryCam
//
//  Created by yf on 2019/1/29.
//  Copyright © 2019 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCCustTextView;
NS_ASSUME_NONNULL_BEGIN

@interface BCCountTextView : UIView
@property (nonatomic,strong)BCCustTextView *textView;
@property (nonatomic,assign)NSInteger maxCharacters;//最大输入字符数
@property (nonatomic,copy)void(^onChangeCb)(BCCustTextView *);
@property (nonatomic,copy)void(^onChangeSelectionCb)(BCCustTextView *);
@end

NS_ASSUME_NONNULL_END
