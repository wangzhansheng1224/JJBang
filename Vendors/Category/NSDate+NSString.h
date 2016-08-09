//
//  NSDate+NSString.h
//  实时语音
//
//  Created by Maybe on 16/2/27.
//  Copyright © 2016年 Maybe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSString)
+(NSString *)setUpTimestampFrom:(NSString *)timeString;
+(NSString *)nowTimestamp;
+(NSString *)setUptime;

@end
