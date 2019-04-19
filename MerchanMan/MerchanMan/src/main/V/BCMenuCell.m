//
//  BCMenuCell.m
//  BatteryCam
//
//  Created by yf on 2017/8/8.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCMenuCell.h"

@interface BCMenuCell ()
@property (nonatomic,strong)UIImageView *redot;
@property (nonatomic,strong)UILabel *badge;
@end

@implementation BCMenuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]){
        [self initUI];
        [self updateLayout];
    }
    return self;
}

-(void)initUI{
    self.clipsToBounds=true;
    
    self.textLabel.font=iFont(16);
    self.textLabel.textColor=iColor(0x22, 0x22, 0x22, 1);
    self.textLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    
    self.selectedBackgroundView=[[UIView alloc]init];
    self.selectedBackgroundView.backgroundColor=iColor(0xf6, 0xf6, 0xf6, 1);
    
    self.redot=[[UIImageView alloc]initWithImage:img(@"new_red_label")];
    [self.contentView addSubview:self.redot];
    self.badge=[IProUtil commonLab:iBFont(dp2po(9)) color:[UIColor whiteColor]];
    [self.contentView addSubview:self.badge];
    self.badge.textAlignment=NSTextAlignmentCenter;
    self.badge.backgroundColor=iColor(0xff, 0x4f, 0x4f, 1);
    self.backgroundColor=iColor(0xfb, 0xfb, 0xfb, 1);
}

-(void)updateLayout{
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.bottom.equalTo(@0);
        make.leading.equalTo(@12);
    }];
    [self.redot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_trailing).offset(dp2po(-36));
        make.centerY.equalTo(@0);
    }];
    
    CGFloat badgeh = dp2po(18);
    self.badge.clipsToBounds=YES;
    self.badge.layer.cornerRadius=badgeh*.5;
    [UIUtil commonShadowWithRadius:4 view:self.badge opacity:.05];
    [self.badge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.redot);
        make.height.equalTo(@(badgeh));
        make.width.greaterThanOrEqualTo(@(badgeh));
    }];
}


-(void)setMod:(BCMenuMod *)mod{
    _mod=mod;
    [self updateUI];
}
-(void)updateUI{
    self.imageView.image=img(_mod.iconname);
    self.textLabel.text=_mod.title;
    
    //TD:消息的g红点提醒移到Camera了
//    self.redot.hidden=!_mod.hasNews||_mod.newNotiCount>0;
//    self.badge.hidden=!_mod.hasNews||_mod.newNotiCount<=0;
//    self.badge.text=iFormatStr(@"%ld",_mod.newNotiCount);
    self.redot.hidden=YES;
    self.badge.hidden=YES;
}






@end
