//
//  NSDate + TimeZone.m
//  Dolphin
//
//  Created by Jim Huang on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDate_TimeZone.h"

#define DATE_COMPONENTS (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

#define D_MINUTE 60
#define D_HOUR 3600
#define D_DAY 86400
#define D_WEEK 604800
#define D_YEAR 31556926

@implementation NSDate (NSDate___TimeZone)

// Convert UNIX timestamp to system time zone.
+ (id)dateWithTimeIntervalSince1970OfSystemTimeZone:(NSTimeInterval)interval
{
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];

    NSDate* destinationDate = [[[NSDate alloc] initWithTimeIntervalSince1970:interval - [destinationTimeZone secondsFromGMT]] autorelease];

    return destinationDate;
}

+ (NSTimeInterval)currentTime
{
    NSDate* date = [NSDate date];

    NSTimeInterval aInterval = [date timeIntervalSince1970];
    return aInterval;
}

+ (NSString*)currentTimeByJava
{
    NSDate* date = [NSDate date];

    NSTimeInterval aInterval = [date timeIntervalSince1970];

    long long java = (long long)(aInterval * 1000);

    return [NSString stringWithFormat:@"%lld", java];
}

+ (NSString*)daySinceDate:(NSDate*)aDate
{
    NSTimeInterval time = [aDate timeIntervalSince1970];
    return [self daySinceTimeInterval:time];
}


+ (NSString *)stringYearMonthDayHourMinuteSecondWithTime:(NSTimeInterval) aTime
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:aTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}
+ (NSString*)daySinceTimeInterval:(NSTimeInterval)time
{
    NSString* addtimeDisplay = @"";
    NSInteger minute = 60;
    NSInteger hour = minute * 60;
    NSInteger day = hour * 24;
    NSInteger now = ceil([[NSDate date] timeIntervalSince1970]);
    NSInteger timeDifference = now - time;
    if (timeDifference > day) {
        long num = timeDifference / 60 / 60 / 24;
        addtimeDisplay = [NSString stringWithFormat:@"%ld 天前", num];
    }
    else if (timeDifference > hour) {
        NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
        NSDate* now;
        NSDateComponents* comps;
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        now = [NSDate date];
        comps = [calendar components:unitFlags fromDate:now];
        NSInteger tHour = [comps hour];
        NSDate* date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        if (timeDifference / 60 / 60 > tHour) {
            addtimeDisplay = [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:date]];
        }
        else {
            addtimeDisplay = [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate:date]];
        }
    }
    else {
        NSInteger minutes = timeDifference / minute;
        if (minutes < 1) {
            addtimeDisplay = @"刚刚";
        }
        else {
            addtimeDisplay = [NSString stringWithFormat:@"%ld 分钟前", (long)minutes];
        }
    }
    return addtimeDisplay;
}

+ (NSString*)dateTimeInterval:(NSTimeInterval)time
{
    NSString* addtimeDisplay = @"";
    NSInteger minute = 60;
    NSInteger hour = minute * 60;
    NSInteger day = hour * 24;
    NSInteger now = ceil([[NSDate date] timeIntervalSince1970]);
    NSInteger timeDifference = now - time;

    NSDate* fromDate = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDate* nowDate = [NSDate date];
    if (timeDifference > day) {
        addtimeDisplay = [fromDate stringMonthDay];
    }
    else if (timeDifference > hour) {
        if (timeDifference / 60 / 60 > [nowDate hour]) {
            addtimeDisplay = [NSString stringWithFormat:@"昨天 %@", [fromDate stringTime]];
        }
        else {
            addtimeDisplay = [NSString stringWithFormat:@"%@", [fromDate stringTime]];
        }
    }
    else {
        addtimeDisplay = [NSString stringWithFormat:@"%@", [fromDate stringTime]];
    }
    return addtimeDisplay;
}

+ (NSString*)dateYMDTimeInterval:(NSTimeInterval)time
{
    NSDate* fromDate = [[[NSDate alloc] initWithTimeIntervalSince1970:time / 1000] autorelease];

    return [fromDate stringYearMonthDay];
}

+ (NSDate*)dateWithYear:(NSInteger)year
                  month:(NSInteger)month
                    day:(NSInteger)day
                   hour:(NSInteger)hour
                 minute:(NSInteger)minute
                 second:(NSInteger)second
{

    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSTimeZone* systemTimeZone = [NSTimeZone systemTimeZone];

    NSDateComponents* dateComps = [[NSDateComponents alloc] init];
    [dateComps setCalendar:gregorian];
    [dateComps setYear:year];
    [dateComps setMonth:month];
    [dateComps setDay:day];
    [dateComps setTimeZone:systemTimeZone];
    [dateComps setHour:hour];
    [dateComps setMinute:minute];
    [dateComps setSecond:second];

    return [dateComps date];
}

+ (NSInteger)daysOffsetBetweenStartDate:(NSDate*)startDate endDate:(NSDate*)endDate
{
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents* comps = [gregorian components:unitFlags fromDate:startDate toDate:endDate options:0];
    NSInteger days = [comps day];
    return days;
}

+ (NSDate*)dateWithHour:(int)hour
                 minute:(int)minute
{
    NSDate* now = [NSDate date];
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
    [components setHour:hour];
    [components setMinute:minute];
    NSDate* newDate = [calendar dateFromComponents:components];
    return newDate;
}

#pragma mark - Data component
- (NSInteger)year
{
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:self];
    return [dateComponents year];
}

- (NSInteger)month
{
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:self];
    return [dateComponents month];
}

- (NSInteger)day
{
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:self];
    return [dateComponents day];
}

- (NSInteger)hour
{
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:self];
    return [dateComponents hour];
}

- (NSInteger)minute
{
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:self];
    return [dateComponents minute];
}

- (NSInteger)second
{
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:self];
    return [dateComponents second];
}

- (NSString*)weekday
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;

    NSDate* date = [NSDate date];
    comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
                        fromDate:date];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSString* week = @"";
    switch (weekday) {
    case 1:
        week = @"星期日";
        break;
    case 2:
        week = @"星期一";
        break;
    case 3:
        week = @"星期二";
        break;
    case 4:
        week = @"星期三";
        break;
    case 5:
        week = @"星期四";
        break;
    case 6:
        week = @"星期五";
        break;
    case 7:
        week = @"星期六";
        break;

    default:
        break;
    }

    return week;
}

#pragma mark - Time string
- (NSString*)timeHourMinute
{

    return [self timeHourMinuteWithPrefix:NO suffix:NO];
}

- (NSString*)timeHourMinuteWithPrefix
{
    return [self timeHourMinuteWithPrefix:YES suffix:NO];
}

- (NSString*)timeHourMinuteWithSuffix
{
    return [self timeHourMinuteWithPrefix:NO suffix:YES];
}

- (NSString*)timeHourMinuteWithPrefix:(BOOL)enablePrefix suffix:(BOOL)enableSuffix
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString* timeStr = [formatter stringFromDate:self];
    if (enablePrefix) {
        timeStr = [NSString stringWithFormat:@"%@%@", ([self hour] > 12 ? @"下午" : @"上午"), timeStr];
    }
    if (enableSuffix) {
        timeStr = [NSString stringWithFormat:@"%@%@", ([self hour] > 12 ? @"pm" : @"am"), timeStr];
    }
    return timeStr;
}

#pragma mark - Date String
- (NSString*)stringTime
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString* str = [formatter stringFromDate:self];
    return str;
}

- (NSString*)stringMonthDay
{
    return [NSDate dateMonthDayWithDate:self];
}

- (NSString*)stringYearMonthDay
{
    return [NSDate stringYearMonthDayWithDate:self];
}

- (NSString*)stringYearMonthDayHourMinuteSecond
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* str = [formatter stringFromDate:self];
    return str;
}

- (NSString*)stringYearMonthDayCompareToday
{
    NSString* str;
    NSInteger chaDay = [self daysBetweenCurrentDateAndDate];
    if (chaDay == 0) {
        str = @"今天";
    }
    else if (chaDay == 1) {
        str = @"明天";
    }
    else if (chaDay == -1) {
        str = @"昨天";
    }
    else {
        str = [self stringYearMonthDay];
    }

    return str;
}

+ (NSString*)stringLoacalDate
{
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    [format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [NSDate date];
    NSTimeZone* zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate* localeDate = [date dateByAddingTimeInterval:interval];
    NSString* dateStr = [format stringFromDate:localeDate];

    return dateStr;
}

+ (NSString*)stringYearMonthDayWithDate:(NSDate*)date
{
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* str = [formatter stringFromDate:date];
    return str;
}

+ (NSString*)dateMonthDayWithDate:(NSDate*)date
{
    if (date == nil) {
        date = [NSDate date];
    }

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString* str = [formatter stringFromDate:date];
    return str;
}

#pragma mark - Date formate

+ (NSString*)dateFormatString
{
    return @"yyyy-MM-dd";
}

+ (NSString*)timeFormatString
{
    return @"HH:mm:ss";
}

+ (NSString*)dateTimeFormatString
{
    return @"MM-dd HH:mm";
}

+ (NSString*)timestampFormatString
{
    return @"yyyy-MM-dd HH:mm:ss";
}

+ (NSString*)timestampFormatStringSubSeconds
{
    return @"yyyy-MM-dd HH:mm";
}

#pragma mark - Date adjust
- (NSDate*)dateByAddingDays:(NSInteger)dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate* newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate*)dateBySubtractingDays:(NSInteger)dDays
{
    return [self dateByAddingDays:(dDays * -1)];
}

#pragma mark - Relative Dates
+ (NSDate*)dateWithDaysFromNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate*)dateWithDaysBeforeNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate*)dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate*)dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate*)dateWithHoursFromNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate* newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate*)dateWithHoursBeforeNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate* newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate*)dateWithMinutesFromNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate* newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate*)dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate* newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (BOOL)isEqualToDateIgnoringTime:(NSDate*)aDate
{
    NSDateComponents* components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents* components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) && (components1.month == components2.month) && (components1.day == components2.day));
}

+ (NSDate*)dateStandardFormatTimeZeroWithDate:(NSDate*)aDate
{
    NSString* str = [[NSDate stringYearMonthDayWithDate:aDate] stringByAppendingString:@" 00:00:00"];
    NSDate* date = [NSDate dateFromString:str];
    return date;
}

- (NSInteger)daysBetweenCurrentDateAndDate
{
    //只取年月日比较
    NSDate* dateSelf = [NSDate dateStandardFormatTimeZeroWithDate:self];
    NSTimeInterval timeInterval = [dateSelf timeIntervalSince1970];
    NSDate* dateNow = [NSDate dateStandardFormatTimeZeroWithDate:nil];
    NSTimeInterval timeIntervalNow = [dateNow timeIntervalSince1970];

    NSTimeInterval cha = timeInterval - timeIntervalNow;
    CGFloat chaDay = cha / 86400.0;
    NSInteger day = chaDay * 1;
    return day;
}

#pragma mark - Date and string convert
+ (NSDate*)dateFromString:(NSString*)string
{
    return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate*)dateFromString:(NSString*)string withFormat:(NSString*)format
{
    NSDateFormatter* inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate* date = [inputFormatter dateFromString:string];
    return date;
}


- (NSString*)string
{
    return [self stringWithFormat:[NSDate dbFormatString]];
}

-(NSString*) stringMonthDayHourMinute{
    return [self stringWithFormat:[NSDate dateTimeFormatString]];
}

- (NSString*)stringCutSeconds
{
    return [self stringWithFormat:[NSDate timestampFormatStringSubSeconds]];
}

- (NSString*)stringWithFormat:(NSString*)format
{
    NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString* timestamp_str = [outputFormatter stringFromDate:self];
    return timestamp_str;
}

+ (NSString*)dbFormatString
{
    return [NSDate timestampFormatString];
}

@end
