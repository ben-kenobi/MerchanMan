

//
//  YFMerchan.m
//  MerchanMan
//
//  Created by hui on 2019/4/20.
//  Copyright © 2019 yf. All rights reserved.
//

#import "YFMerchan.h"

@implementation YFMerchan
-(NSAttributedString *)detailAttrDesc{
    NSMutableAttributedString *mastr = [[NSMutableAttributedString alloc]init];
    if(!emptyStr(self.inPrice)){
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:@"进价：" attributes:@{NSForegroundColorAttributeName:iColor(0xaa, 0xaa, 0xaa, 1)}]];
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:self.inPrice]];
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:@"        "]];
    }
    if(!emptyStr(self.outPrice)){
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:@"出价：" attributes:@{NSForegroundColorAttributeName:iColor(0xaa, 0xaa, 0xaa, 1)}]];
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:self.outPrice]];
    }
    if(!emptyStr(self.remark)){
        [mastr appendAttributedString: [[NSAttributedString alloc]initWithString:@"\n\n" attributes:@{NSFontAttributeName:iFont(8)}]];
        [mastr appendAttributedString: [[NSAttributedString alloc]initWithString:self.remark attributes:@{NSFontAttributeName:iFont(12),NSForegroundColorAttributeName:iColor(0x88, 0x88, 0x88, 1)}]];
    }
    return [[NSAttributedString alloc]initWithAttributedString:mastr];
}

-(NSURL *)defIconUrl{
    if(self.iconPaths.count<=0) return nil;
    return iFURL(self.iconPaths.firstObject);
}
-(UIImage *)defIcon{
    return img(@"defimgicon");
}


-(instancetype)init{
    if(self = [super init]){
        self.ID = [NSUUID UUID].UUIDString;
        self.addTime = [NSDate date];
        self.updateTime = [NSDate date];
        self.remark = @"";
        self.name = @"";
    }return self;
}

-(BOOL)isEqual:(id)object{
    if(!object) return NO;
    if(![object isKindOfClass:YFMerchan.class]) return NO;
    YFMerchan *other = object;
    return [other.ID isEqual:self.ID];
}
@end
