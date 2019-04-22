//
//  BCCustTextView.h
//  BatteryCam
//
//  Created by yf on 2017/11/7.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCCustTextView : UITextView
@property (nonatomic,copy)NSString *placeholder;
@property (nonatomic,assign)NSInteger maxCharacters;//最大输入字符数

-(void)insertImg:(UIImage *)img path:(NSString *)path;
-(NSString *)fullTxt;
@property (nonatomic,copy)void(^onChangeCb)(BCCustTextView *);
@property (nonatomic,copy)void(^onChangeSelectionCb)(BCCustTextView *);

@end
