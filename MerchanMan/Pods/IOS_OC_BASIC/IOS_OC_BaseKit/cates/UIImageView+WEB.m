//
//  UIImageView+WEB.m
//Created by apple on 17/07/21.
//

#import "UIImageView+WEB.h"
#import "objc/runtime.h"


static const char * key="adrkey";

@implementation UIImageView (WEB)
-(NSString *)adr{
    return objc_getAssociatedObject(self, key);
}

-(void)setAdr:(NSString *)adr {
    objc_setAssociatedObject(self, key, adr, OBJC_ASSOCIATION_COPY);
}

@end
