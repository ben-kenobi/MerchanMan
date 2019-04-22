//
//  BCCountTextView.m
//  BatteryCam
//
//  Created by yf on 2019/1/29.
//  Copyright © 2019 oceanwing. All rights reserved.
//

#import "BCCountTextView.h"
#import "BCCustTextView.h"
#import "BCCustTextView.h"
@interface BCCountTextView()
@property (nonatomic,strong)UILabel *countLab;

@end
@implementation BCCountTextView


-(void)setMaxCharacters:(NSInteger)maxCharacters{
    _maxCharacters=maxCharacters;
    self.textView.maxCharacters=maxCharacters;
    [self countLab];
    [self updateUI];
}

-(void)updateUI{
    _countLab.hidden=self.maxCharacters==0;
    _countLab.text=iFormatStr(@"%ld/%ld",MIN(self.textView.text.length,self.maxCharacters),self.maxCharacters);
}

#pragma mark - UI
-(instancetype)init{
    if(self = [super init]){
        [self initUI];
    }
    return self;
}
-(void)initUI{
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}
-(BCCustTextView *)textView{
    if(_textView)return _textView;
    // content Sv ---begin
    
    _textView=[[BCCustTextView alloc]init];
    _textView.textContainerInset=UIEdgeInsetsMake(dp2po(10), dp2po(10), 12, 6);
    _textView.font=iFont(dp2po(16));
    _textView.textColor=iColor(0x33, 0x33, 0x33, 1);
    @weakRef(self)
    [_textView setOnChangeCb:^(BCCustTextView *tv) {
        [weak_self updateUI];
        if(weak_self.onChangeCb)
            weak_self.onChangeCb(tv);
    }];
    [_textView setOnChangeSelectionCb:^(BCCustTextView *tv) {
        if(weak_self.onChangeSelectionCb)
            weak_self.onChangeSelectionCb(tv);
    }];
    return _textView;
}
-(UILabel *)countLab{
    if(!_countLab){
        _countLab=[IProUtil commonLab:iFont(16) color:iColor(0xcc, 0xcc, 0xcc, 1)];
        _countLab.textAlignment=NSTextAlignmentRight;
        _countLab.numberOfLines=1;
        [self addSubview:_countLab];
        [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(dp2po(-8)));
            make.trailing.equalTo(@(dp2po(-12)));
        }];
        _countLab.hidden=YES;
    }
    return _countLab;
}


@end
