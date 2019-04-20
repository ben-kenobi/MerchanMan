

//
//  YFMerchantCell.m
//  MerchanMan
//
//  Created by hui on 2019/4/20.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchantCell.h"
#import "UIImageView+WebCache.h"
@interface YFMerchantCell()
@end


@implementation YFMerchantCell

-(void)setMod:(YFMerchan *)mod{
    _mod = mod;
    [self updateUI];
}
#pragma mark - update
-(void)updateUI{
    [self.imageView sd_setImageWithURL:self.mod.defIconUrl placeholderImage:self.mod.defIcon completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [image sd_resizedImageWithSize:CGSizeMake(50, 50) scaleMode:(SDImageScaleModeAspectFill)];
    }];
    self.textLabel.text = self.mod.name;
    self.detailTextLabel.attributedText = self.mod.detailAttrDesc;
    
}

#pragma mark - init

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }return self;
}

-(void)initUI{
    self.textLabel.font = iBFont(17);
    self.textLabel.textColor = iColor(0x22, 0x22, 0x22, 1);
    self.detailTextLabel.font = iFont(14);
    self.detailTextLabel.textColor = iColor(0x55, 0x55, 0x55, 1);
    self.textLabel.numberOfLines = 0;
    self.detailTextLabel.numberOfLines = 0;
}

@end
