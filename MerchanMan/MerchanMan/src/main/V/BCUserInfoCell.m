
//
//  BCUserInfoCell.m
//  BatteryCam
//
//  Created by yf on 2017/8/8.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCUserInfoCell.h"

@interface BCUserInfoCell ()
@property(nonatomic,strong)UIImageView *avatar;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *detailLab;
//@property (nonatomic,strong)UIImageView *bg;
@end

@implementation BCUserInfoCell



#pragma mark - Event
-(void)updateUserInfo{
    self.avatar.image=img(@"icon_app");
    self.detailLab.text=@"";
    self.titleLab.text=@"商品管理";
    [self updateLayout];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(self.avatar.frame,[touches.anyObject locationInView:self])){
        if(self.cb)
            self.cb();
    }
}




#pragma mark - UI
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}
-(void)dealloc{
    [iNotiCenter removeObserver:self];
}

-(void)initUI{
    self.contentView.backgroundColor=iColor(0xFB, 0xFB, 0xFB, 1);
    self.clipsToBounds=true;
//    self.bg=[[UIImageView alloc]initWithImage:img(@"personal_bg")];
//    self.bg.contentMode=UIViewContentModeScaleAspectFill;
    
    self.titleLab=[IProUtil commonLab:iBFont(dp2po(20)) color:iColor(0x34, 0x35, 0x36, 1)];
    self.titleLab.lineBreakMode=NSLineBreakByTruncatingTail;
    self.titleLab.textAlignment=NSTextAlignmentCenter;

    self.detailLab=[IProUtil commonLab:iFont(dp2po(12)) color:iColor(0xAB, 0xAC, 0xAD, 1)];
    self.detailLab.lineBreakMode=NSLineBreakByTruncatingTail;
    self.detailLab.numberOfLines=1;
    self.detailLab.textAlignment=NSTextAlignmentCenter;
    
    self.avatar=[[UIImageView alloc]init];
    [UIUtil commonShadowWithRadius:4 view:self.avatar opacity:.2];
    
//    [self.contentView addSubview:self.bg];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.detailLab];
    [self.contentView addSubview:self.avatar];


//    [self.imageView measurePriority:1000 hor:false];
//    [self.textLabel measurePriority:500 hor:false];
//    [self.detailTextLabel measurePriority:500 hor:false];
    
}

-(void)updateLayout{
    /*
    [self.bg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(@0);
        make.height.equalTo(self);
    }];
     */
     
    [self.avatar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.mas_centerY).offset(-10);
        make.height.width.equalTo(@62);
    }];
    
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.avatar.mas_bottom).offset(8);
        make.leading.equalTo(@10);
        make.trailing.equalTo(@(-10));
    }];
    
    [self.detailLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.leading.equalTo(@10);
        make.trailing.equalTo(@(-10));
        make.top.equalTo(self.titleLab.mas_bottom).offset(4);
    }];
    
}





@end
