//
//  NSDate+NSString.m
//  实时语音
//
//  Created by Maybe on 16/2/27.
//  Copyright © 2016年 Maybe. All rights reserved.
//

#import "NSDate+NSString.h"

@implementation NSDate (NSString)


//计算时间戳
+(NSString *)setUpTimestampFrom:(NSString *)timeString
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate * date = [formatter dateFromString:timeString];
    NSString * timeSp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    return timeSp;

}
+(NSString *)nowTimestamp
{
    //当前的时间戳
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString * timeString = [formatter stringFromDate:[NSDate date]];
    NSDate * date = [formatter dateFromString:timeString];
    NSString * timeStr = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    return timeStr;
}
+(NSString *)setUptime
{
    //按照文档要求获取时间格式
    NSDateFormatter * dateForMatter= [[NSDateFormatter alloc]init];
    [dateForMatter setDateFormat:@"MMddHHmmss"];
    NSString * currentDateString = [dateForMatter stringFromDate:[NSDate date]];
    
    return currentDateString;
}


@end
