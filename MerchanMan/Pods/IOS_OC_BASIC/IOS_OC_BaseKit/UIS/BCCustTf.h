//
//  BCCustTf.h
//  BatteryCam
//
//  Created by yf on 2017/10/25.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCCustTf : UITextField<UITextFieldDelegate>
@property (nonatomic,copy)void(^onTextChange)(BCCustTf *tf);
@property (nonatomic,copy)void(^onReturn)(BCCustTf *tf);
@property (nonatomic,copy)void(^onEditingChange)(BCCustTf *tf);
@property (nonatomic,copy)BOOL(^shouldBeginEditing)(BCCustTf *tf);


@property (nonatomic,assign)BOOL adjustFocusColor;
@property (nonatomic,strong)UIView *topline;
@property (nonatomic,strong)UIView *bottomLine;
@property (nonatomic,assign)CGFloat leftPad;
@property (nonatomic,assign)CGFloat rightPad;
@property (nonatomic,assign)BOOL showArrow;
@property (nonatomic,assign)NSInteger maxLen;
@property (nonatomic,copy)void(^onArrowClick)(UIButton *arrowBtn,BCCustTf *tf);
-(void)onShowArrow;
-(void)updateTextContentByMaxLen;// 判断文字长度是否超过最大限制
-(void)onContentChange;// 文字内容变化，此方法内不可在修改文字内容
@end
