

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
    if(!emptyStr(self.barCode)){
        [mastr appendAttributedString: [[NSAttributedString alloc]initWithString:@"\n\n" attributes:@{NSFontAttributeName:iFont(6)}]];
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:@"条码：" attributes:@{NSForegroundColorAttributeName:iColor(0xaa, 0xaa, 0xaa, 1)}]];
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:self.barCode]];
    }
    if(!emptyStr(self.remark)){
        [mastr appendAttributedString: [[NSAttributedString alloc]initWithString:@"\n\n" attributes:@{NSFontAttributeName:iFont(6)}]];
        [mastr appendAttributedString: [[NSAttributedString alloc]initWithString:self.remark attributes:@{NSFontAttributeName:iFont(13),NSForegroundColorAttributeName:iColor(0x88, 0x88, 0x88, 1)}]];
    }
    return [[NSAttributedString alloc]initWithAttributedString:mastr];
}

-(NSAttributedString *)fullAttrDesc{
    NSMutableAttributedString *mastr = [[NSMutableAttributedString alloc]init];
    [mastr appendAttributedString: [[NSAttributedString alloc] initWithString:self.name attributes:@{NSForegroundColorAttributeName:iColor(0x33, 0x33, 0x33, 1),NSFontAttributeName:iBFont(18)}]];
    [mastr appendAttributedString: [[NSAttributedString alloc]initWithString:@"\n\n" attributes:@{NSFontAttributeName:iFont(6)}]];
    [mastr appendAttributedString:[self detailAttrDesc]];
    
    
    [mastr appendAttributedString: [[NSAttributedString alloc]initWithString:@"\n\n" attributes:@{NSFontAttributeName:iFont(16)}]];
    
    NSDictionary *attdict =@{NSFontAttributeName:iFont(12),NSForegroundColorAttributeName:iColor(0xad, 0xad, 0xad, 1)};
    if(self.updateTime){
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:@"修改时间：" attributes:@{NSForegroundColorAttributeName:iColor(0xbb, 0xbb, 0xbb, 1),NSFontAttributeName:iFont(12)}]];
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:self.updateTime.timeFormat2 attributes:attdict]];
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:@"\n"]];
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:@"添加时间：" attributes:@{NSForegroundColorAttributeName:iColor(0xbb, 0xbb, 0xbb, 1),NSFontAttributeName:iFont(12)}]];
        [mastr appendAttributedString:[[NSAttributedString alloc]initWithString:self.addTime.timeFormat2 attributes:attdict]];
    }
    
    return [[NSAttributedString alloc]initWithAttributedString:mastr];
}

-(NSURL *)defIconUrl{
    if(self.iconIDs.count<=0) return nil;
    return iFURL([YFMerchanUtil fullImgPathByID:self.iconIDs.firstObject]);
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
