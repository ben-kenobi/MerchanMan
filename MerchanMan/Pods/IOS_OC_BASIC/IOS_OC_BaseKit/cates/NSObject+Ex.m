//
//  NSObject+Ex.m
//Created by apple on 17/07/21.
//

#import "NSObject+Ex.h"
#import "IUtil.h"
@implementation NSObject (Ex)


//调用kvc方法设置值
+(instancetype)setDict:(NSDictionary *)dict{
    //    return [IUtil setterValues:dict forClz:self];
    return [IUtil setValues:dict forClz:self];
}

//调用对象的setter方法设置值
+(instancetype)setterDict:(NSDictionary *)dict{
//    return [IUtil setValues:dict forClz:self];
    return [IUtil setterValues:dict forClz:self];
}

-(void)setDict:(NSDictionary *)dict{
    //    [IUtil setterValues:dict forObj:self];
    [IUtil setValues:dict forObj:self];
}
-(void)setterDict:(NSDictionary *)dict{
    return [IUtil setterValues:dict forObj:self];
}

-(NSDictionary *)dict{
    return [self dictionaryWithValuesForKeys:[IUtil prosWithClz:self.class]];
}

@end
