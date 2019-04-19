//
//  NSString+Ex.h
//Created by apple on 17/07/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Ex)

-(instancetype)strByAppendToCachePath;
-(instancetype)strByAppendToDocPath;
-(instancetype)strByAppendToTempPath;
-(BOOL)ignorecaseEqualTo:(NSString *) str;
-(unsigned int)toHexValue;
-(int64_t)toHexLongValue;
-(UInt8)toHexByte;
-(CGSize)sizeBy:(UIFont *)font;
-(CGSize)sizeBy:(CGSize)size font:(UIFont *)font;
-(NSAttributedString *)h5Str;

//将标准base64的字符串转化为urlsafe的base64字符串
-(NSString *)toUrlsafeBase64Str;
//将urlsafe的base64的字符串转化为标准base64字符串
-(NSString *)toStandardBase64Str;
@end
