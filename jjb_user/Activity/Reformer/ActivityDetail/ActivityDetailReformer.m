//
//  ActivityDetailReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityDetailReformer.h"
#import "ActivityDetailAPIManager.h"

NSString *const kActivityDetailID=@"ActivityDetailID";
NSString *const kActivityDetailTitle=@"ActivityDetailTitle";
NSString *const kActivityDetailTime=@"ActivityDetailTime";
NSString *const kActivityDetailContent=@"ActivityDetailImg";
NSString *const kActivityDetailIntro=@"ActivityDetailPrice";
NSString *const kActivityDetailRegistCount=@"ActivityDetailRegistCount";
NSString *const kActivityDetailImages=@"ActivityDetailImages";
NSString *const kActivityDetailIsRegist=@"ActivityDetailIsRegist";
NSString *const kActivityDetailState=@"ActivityDetailState";
NSString *const kActivityDetailAddress=@"ActivityDetailAddress";
NSString *const kActivityDetailEndTime=@"ActivityDetailEndTime";

@implementation ActivityDetailReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
     if ([manager isKindOfClass:[ActivityDetailAPIManager class]]) {
         
         NSDictionary *dicData=data[@"data"];
         NSDate *startTime=[NSDate dateWithTimeIntervalSince1970:[dicData[@"starttime"] doubleValue]/1000];
         //结束时间
         NSDate *endTime=[NSDate dateWithTimeIntervalSince1970:[dicData[@"endtime"] doubleValue]/1000];
         NSString *endTimeString = [endTime formattedDateWithFormat:@"YYYY-MM-dd hh:mm"];
         //现在的时间
         NSDate * date = [NSDate date];
         
         NSString *strTime=[NSString stringWithFormat:@"%@至%@",[startTime formattedDateWithFormat:@"YYYY-MM-dd hh:mm"],endTimeString];
         NSString *endInteger = nil;
         //时间结束
         if ([date compare:endTime] == -1){
             //结束
             endInteger = @"0";
         }else{
             endInteger = @"1";
         }
       return  @{
           kActivityDetailID:dicData[@"id"],
           kActivityDetailEndTime:endInteger,
           kActivityDetailTitle:dicData[@"title"],
           kActivityDetailTime:strTime,
           kActivityDetailContent:dicData[@"content"],
           kActivityDetailIntro:dicData[@"intro"],
           kActivityDetailRegistCount:dicData[@"registCount"],
           kActivityDetailImages:dicData[@"images"],
           kActivityDetailIsRegist:dicData[@"isRegist"],
           kActivityDetailState:dicData[@"state"],
           kActivityDetailAddress:dicData[@"address"]
           };
     }
    return nil;
}
@end
