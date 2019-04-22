//
//  BCTopIconBtn.m
//  BatteryCam
//
//  Created by yf on 2017/8/18.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "BCTopIconBtn.h"

@implementation BCTopIconBtn


-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.cx=self.icx;
    self.imageView.y=11;
    self.titleLabel.cx=self.icx;
    self.titleLabel.b=self.h-5;
    self.titleLabel.w=self.w;
    self.titleLabel.x=0;
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    
}

@end
