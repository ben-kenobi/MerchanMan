//
//  UIColor+Extension.m
//Created by apple on 17/07/21.
//

#import "UIColor+Ex.h"




@implementation UIColor (Ex)
+(instancetype)randColor{
    return [self colorWithRed:[self randomFloat:255] green:[self randomFloat:255] blue:[self randomFloat:255] alpha:1];
}

+(CGFloat)randomFloat:(NSInteger)base{
    return arc4random()%(base+1)/(base*1.0);
}
+(instancetype)colorWithHex:(NSString *)hexstr{
    hexstr=[[hexstr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    NSInteger from=0,to=2;
    CGFloat fs[4]={0,0,0,1};
    int i=0;
    while(from<hexstr.length-1&&from<8){
        if(hexstr.length-from<to)to=hexstr.length-from;
        unsigned int val;
        [[NSScanner scannerWithString:[hexstr substringWithRange:(NSRange){from,to}] ] scanHexInt:&val];
        fs[i]=val/255.0;
        i++;
        from+=to;
    }
    return [self colorWithRed:fs[0] green:fs[1] blue:fs[2] alpha:fs[3]];
}


@end
