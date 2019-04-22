
//
//  BCCustTextView.m
//  BatteryCam
//
//  Created by yf on 2017/11/7.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCCustTextView.h"
#import "BCImgAttach.h"

@interface BCCustTextView ()<UITextViewDelegate>
@property (nonatomic,strong)UILabel *phlab;
@end

@implementation BCCustTextView


#pragma mark - actions
-(void)onChange{
    [self updateUI];
    if(self.onChangeCb)
        self.onChangeCb(self);
}

#pragma mark - getter & setter
-(UILabel *)phlab{
    if(!_phlab){
        _phlab=[IProUtil commonLab:self.font color:iColor(0xcc, 0xcc, 0xcc, 1)];
        _phlab.textAlignment=NSTextAlignmentLeft;
        _phlab.numberOfLines=0;
        [self addSubview:_phlab];
        [self updatePhlab];
    }
    return _phlab;
}

-(void)updateUI{
    self.phlab.hidden=[self hasText];
}

-(void)setPlaceholder:(NSString *)placeholder{
    self.phlab.text=placeholder;
}
-(NSString *)placeholder{
    return self.phlab.text;
}
-(void)setTextContainerInset:(UIEdgeInsets)textContainerInset{
    [super setTextContainerInset:textContainerInset];
    [self updatePhlab];
}
-(void)updatePhlab{
    [self.phlab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(self.textContainerInset.left+6));
        make.trailing.equalTo(@(-self.textContainerInset.right));
        make.top.equalTo(@(self.textContainerInset.top));
        make.bottom.equalTo(@(-self.textContainerInset.bottom));
    }];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.phlab.font=font;
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self onChange];
}


#pragma mark - UI
-(instancetype)init{
    if(self = [super init]){
        [iNotiCenter addObserver:self selector:@selector(onChange) name:UITextViewTextDidChangeNotification object:self];
        self.delegate=self;
    }
    return self;
}

-(void)dealloc{
    [iNotiCenter removeObserver:self];
}


-(void)insertImg:(UIImage *)img path:(NSString *)path{
    NSRange  range=self.selectedRange;
    if([self.delegate respondsToSelector:@selector(textView: shouldChangeTextInRange: replacementText:)]){
        //手动改变TextVIew的值，不会触发该回调，需手动调用
        if(![self.delegate textView:self shouldChangeTextInRange:range replacementText:@""])
            return;
    }
    
    NSMutableAttributedString *matr=[[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    [matr replaceCharactersInRange:range withAttributedString:[BCImgAttach attStrWith:img path:path]];
    [matr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, matr.length)];
    self.attributedText=matr;
    self.selectedRange=NSMakeRange(range.location+1, 0 );
    [self onChange];
    if([self.delegate respondsToSelector:@selector(textViewDidChange:)]){
        //手动改变TextVIew的值，不会触发该回调，需手动调用
        [self.delegate textViewDidChange:self];
    }

}





-(NSString *)fullTxt{
    NSAttributedString *astr =  self.attributedText;
    NSMutableString * str=[[NSMutableString alloc] initWithString:astr.string];
    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange: NSMakeRange(0,astr.length) options:(NSAttributedStringEnumerationReverse) usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if([value isKindOfClass:BCImgAttach.class]){
            [str replaceCharactersInRange:range withString:[(BCImgAttach*)value path]];
        }
    }];
    return str;
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(emptyStr(text) || self.maxCharacters<=0)return YES;
    if(textView.text.length-range.length+text.length>self.maxCharacters)return NO;
    return YES;
}
//
//- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
//    NSLog(@"%@=====%ld======",NSStringFromRange(characterRange),interaction);
//    return YES;
//}
//
//- (void)textViewDidChange:(UITextView *)textView{
//    NSLog(@"textViewDidChange==%@====",NSStringFromCGSize(self.contentSize));
//}
//
- (void)textViewDidChangeSelection:(UITextView *)textView{
//    NSLog(@"textViewDidChangeSelection======");
    if(self.onChangeSelectionCb)
        self.onChangeSelectionCb(self);
}


@end



    
    
    
    
