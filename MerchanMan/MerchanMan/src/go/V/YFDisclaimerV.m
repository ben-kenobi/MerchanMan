

//
//  BCDisclaimerV.m
//  BatteryCam
//
//  Created by yf on 2017/10/26.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "YFDisclaimerV.h"
@interface YFDisclaimerV ()

{
    NSRange termRange;
    NSMutableAttributedString *mStr;
}
@end

@implementation YFDisclaimerV

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchPoint:[touches.anyObject locationInView:self]];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endTouchAtPoint:[touches.anyObject locationInView:self]];

}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchPoint:[touches.anyObject locationInView:self]];
}
-(void)touchPoint:(CGPoint)po{
    self.selectedTextRange=[self characterRangeAtPoint:po];
    if(NSLocationInRange(self.selectedRange.location, termRange)){
        NSMutableAttributedString *attrstr= [mStr mutableCopy];
        [attrstr addAttributes:@{NSBackgroundColorAttributeName:[iGlobalFocusColor colorWithAlphaComponent:.5]} range:termRange];
        [self setAttributedText:attrstr];
    }else{
        [self setAttributedText:mStr];
    }
}
-(void)endTouchAtPoint:(CGPoint)po{
    [self setAttributedText:mStr];
    self.selectedTextRange=[self characterRangeAtPoint:po];
    if(NSLocationInRange(self.selectedRange.location, termRange)){
        self.protocolActionBlock(0);
    }
}



#pragma mark - UI

-(instancetype)initWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment action:(ProtocolActionBlock)block{
    if(self=[super init]){
        self.protocolActionBlock=block;
        [self initUIWithText:text textAlignment:textAlignment];
    }
    return self;
}

-(void)initUIWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment{
    self.backgroundColor=[UIColor clearColor];
    self.editable=NO;
    self.scrollEnabled=NO;
    self.selectable=NO;
    self.contentInset=UIEdgeInsetsZero;
    self.textContainerInset=UIEdgeInsetsZero;
    self.textContainer.lineFragmentPadding=0;
    self.userInteractionEnabled=YES;
    
    self.font=iFont(dp2po(14));
    self.textColor=iColor(0x66, 0x66, 0x66, 1);
    NSString *fullstr = text;
    
    NSMutableParagraphStyle* centerParagraphStyle = [[NSMutableParagraphStyle alloc]init];
    centerParagraphStyle.lineSpacing = dp2po(15);
    centerParagraphStyle.alignment=NSTextAlignmentCenter;
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = dp2po(6);
    paragraphStyle.alignment=textAlignment;
    mStr= [[NSMutableAttributedString alloc]initWithString:fullstr attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:self.textColor,NSFontAttributeName:self.font}];
    

    
    termRange =[fullstr rangeOfString:@"使用许可和隐私条款"];
    [mStr addAttribute:NSForegroundColorAttributeName value:iColor(0x32, 0x9b, 0xfa, 1) range:termRange];
    
    self.attributedText=mStr;
}


@end
