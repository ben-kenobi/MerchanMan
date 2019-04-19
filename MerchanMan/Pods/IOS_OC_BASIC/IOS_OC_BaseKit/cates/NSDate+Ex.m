//
//  NSDate+Ex.m
//Created by apple on 17/07/21.
//

#import "NSDate+Ex.h"
#import "objc/runtime.h"
#import "YFCate.h"

@implementation NSDate (Ex)


+(instancetype)fromCommonDateFormat:(NSString*)datestr{
    NSDateFormatter* fm=[[NSDateFormatter alloc] init];
    fm.dateFormat=@"EEE MMM dd HH:mm:ss z yyyy";
    fm.locale=[NSLocale localeWithLocaleIdentifier:@"en_US"];
    return [fm dateFromString:datestr];

}

-(NSString *)toCommonDateFormat{
    NSDateFormatter* fm=[[NSDateFormatter alloc] init];
    fm.dateFormat=@"EEE MMM dd HH:mm:ss z yyyy";
    fm.locale=[NSLocale localeWithLocaleIdentifier:@"en_US"];
    return [fm stringFromDate:self];
}

-(NSString *)postDateString {
    NSDateFormatter* fm=[[NSDateFormatter alloc] init];
    
    fm.locale=[NSLocale localeWithLocaleIdentifier:@"en_US"];
    
    if ([self isThisYear]) {
        if (self.isToday) {
            NSInteger result = -self.timeIntervalSinceNow;
            
            if (result < 60) {
                return NSLocalizedString(@"bc.other.a_moment_ago",0);
            }else if (result < 60 * 60) {
                return iFormatStr(@"%ld %@",result/60,NSLocalizedString(@"bc.other.minutes_ago",0));
            }else{
                fm.dateFormat = @"HH:mm";
            }
        }else if (self.isYesterday) {
            fm.dateFormat = iFormatStr(@"'%@' HH:mm",NSLocalizedString(@"bc.other.yesterday",0));
        }else{
            fm.dateFormat = @"MM-dd HH:mm";
        }
    }else {
        fm.dateFormat = @"yyyy-MM-dd HH";
    }
    return [fm stringFromDate:self];
    
}


-(BOOL)isThisYear{
//    NSDate * currentDate = [NSDate date];
//    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
//    fm.dateFormat = @"yyyy";
//    fm.locale = [NSLocale localeWithLocaleIdentifier: @"en_US"];
//    NSString *str=[fm stringFromDate:self];
//    NSString *curdateStr=[fm stringFromDate:currentDate];
//    return [str isEqualToString:curdateStr];
    return [self isSameYear:[NSDate date]];
}
-(NSInteger)dayOfWeek{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger dayofWeek;
    [calendar getEra:0 yearForWeekOfYear:0 weekOfYear:0 weekday:&dayofWeek fromDate:self];
    return dayofWeek;
}

-(BOOL)isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDateInToday:self];
}

-(BOOL)isWeekend{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDateInWeekend:self];
}
-(BOOL)isTomorrow{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDateInTomorrow:self];
}
-(BOOL)isYesterday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDateInYesterday:self];
}
-(BOOL)isSameDay:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDate:self inSameDayAsDate:date];
}

-(BOOL)isSameWeek:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDate:self equalToDate:date toUnitGranularity:NSCalendarUnitWeekday];
}
-(BOOL)isSameMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDate:self equalToDate:date toUnitGranularity:NSCalendarUnitMonth];
}
-(BOOL)isSameYear:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDate:self equalToDate:date toUnitGranularity:NSCalendarUnitYear];
}

-(BOOL)isSameHour:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDate:self equalToDate:date toUnitGranularity:NSCalendarUnitHour];
}
-(BOOL)isSameMinute:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDate:self equalToDate:date toUnitGranularity:NSCalendarUnitMinute];
}
-(NSDate *)convertToToday{
    if(self.isToday)return self;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger era,year,month,day,hour,minute,sec,nanosec;
    [calendar getEra:&era year:&year month:&month day:&day fromDate:[NSDate date]];
    [calendar getHour:&hour minute:&minute second:&sec nanosecond:&nanosec fromDate:self];
    return [calendar dateWithEra:era year:year month:month day:day hour:hour minute:minute second:sec nanosecond:nanosec];
}





-(NSString *)dateFormat{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd";
    }
    return [fm stringFromDate:self];
    
}

-(NSString *)dateFormat2{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"EEE MMM dd";
        fm.locale=[NSLocale localeWithLocaleIdentifier:@"en_US"];
    }
    return [fm stringFromDate:self];
}
-(NSString *)dateFormat3{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"EEE MMM dd, yyyy";
        fm.locale=[NSLocale localeWithLocaleIdentifier:@"en_US"];
    }
    return [fm stringFromDate:self];
}

-(NSString *)timeFormat{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    }
    return [fm stringFromDate:self];
}
-(NSString *)timeMilliFormat{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd HH:mm:ss.SSS";
    }
    return [fm stringFromDate:self];
}

-(NSString *)timeFormat2{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd HH:mm";
    }
    return [fm stringFromDate:self];
}

-(NSString *)timeFormat3{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"MM-dd HH:mm";
    }
    return [fm stringFromDate:self];
}

-(NSString *)timeFormat4{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"HH:mm:ss";
    }
    return [fm stringFromDate:self];
}
-(NSString *)timeFormat5{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"HH:mm";
    }
    return [fm stringFromDate:self];
}
+(instancetype)dateFromStr:(NSString *)str{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd";
    }
    return [fm dateFromString:str];
}
+(instancetype)timeFromStr:(NSString *)str{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    }
    return [fm dateFromString:str];
}


+(instancetype)timeMilliFromStr:(NSString *)str{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd HH:mm:ss.SSS";
    }
    return [fm dateFromString:str];
}

+(int64_t)curTimeMilli{
    return [[NSDate date] timeIntervalSince1970]*1000;
}
+(NSDate *)dateWithMilli:(int64_t)millis{
    return [NSDate dateWithTimeIntervalSince1970:millis/1000];
}


-(BOOL)viewed{
    return [objc_getAssociatedObject(self,@"viewed") boolValue];
}
-(void)setViewed:(BOOL)viewed{
    objc_setAssociatedObject(self, @"viewed", @(viewed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
