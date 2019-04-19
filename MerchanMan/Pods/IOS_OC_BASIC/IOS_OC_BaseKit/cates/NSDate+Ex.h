//
//  NSDate+Ex.h
//Created by apple on 17/07/21.
//

#import <Foundation/Foundation.h>

@interface NSDate (Ex)
@property (nonatomic,assign)BOOL viewed;
-(NSString *)dateFormat;
-(NSString *)dateFormat2;
-(NSString *)dateFormat3;
-(NSString *)timeFormat;
-(NSString *)timeFormat2;
-(NSString *)timeFormat3;
-(NSString *)timeFormat4;
-(NSString *)timeFormat5;
-(NSString *)timeMilliFormat;
+(instancetype)dateFromStr:(NSString *)str;
+(instancetype)timeFromStr:(NSString *)str;
+(instancetype)timeMilliFromStr:(NSString *)str;
+(int64_t)curTimeMilli;
+(NSDate *)dateWithMilli:(int64_t)millis;

+(instancetype)fromCommonDateFormat:(NSString*)datestr;
-(NSString *)toCommonDateFormat;

-(NSString *)postDateString ;

-(BOOL)isThisYear;
-(NSInteger)dayOfWeek;//sunday is first day 1 and saturday is 7
-(BOOL)isToday;
-(BOOL)isWeekend;
-(BOOL)isTomorrow;
-(BOOL)isYesterday;
-(BOOL)isSameDay:(NSDate *)date;
-(BOOL)isSameWeek:(NSDate *)date;
-(BOOL)isSameMonth:(NSDate *)date;
-(BOOL)isSameYear:(NSDate *)date;
-(BOOL)isSameHour:(NSDate *)date;
-(BOOL)isSameMinute:(NSDate *)date;
-(NSDate *)convertToToday;//将日期变成今天的日期，时分秒不变

@end
