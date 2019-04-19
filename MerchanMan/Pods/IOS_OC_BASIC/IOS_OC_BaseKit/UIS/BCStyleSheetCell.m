//
//  BCStyleSheetCell.m
//  BatteryCam
//
//  Created by yf on 2017/8/16.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCStyleSheetCell.h"
#import "YFCate.h"
@implementation BCStyleSheetCell

-(void)updateUI{
    self.imageView.image=_mod.icon;
    self.textLabel.text=_mod.title;
    if(_mod.icon){
        [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.leading.equalTo(self.imageView.mas_trailing).offset(35);
        }];
        self.textLabel.textColor=_mod.titleColor?_mod.titleColor : iColor(0x55, 0x55, 0x55, 1);
        
    }else{
        self.textLabel.textColor=_mod.titleColor?_mod.titleColor : iColor(0x33, 0x33, 0x33, 1);
        [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.centerX.equalTo(@0);
        }];
    }
    
}

-(void)setMod:(BCStyleSheetMod *)mod{
    _mod=mod;
    [self updateUI];
}

#pragma mark - UI

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.backgroundColor=iColor(0xfc, 0xfc, 0xfc, 1);
    self.selectedBackgroundView=[[UIView alloc]init];
    self.selectedBackgroundView.backgroundColor=iColor(0xf0, 0xf0, 0xf0, 1);
    self.textLabel.font=iFont(dp2po(17));
    self.textLabel.textColor=iColor(0x55, 0x55, 0x55, 1);
    [self.contentView  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(@0);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.leading.equalTo(@35);
    }];
    
}


@end
