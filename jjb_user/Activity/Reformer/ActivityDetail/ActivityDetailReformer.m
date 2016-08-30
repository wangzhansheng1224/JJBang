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

@implementation ActivityDetailReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
     if ([manager isKindOfClass:[ActivityDetailAPIManager class]]) {
         
         NSDictionary *dicData=data[@"data"];
         NSDate *startTime=[NSDate dateWithTimeIntervalSince1970:[dicData[@"starttime"] doubleValue]/1000];
         
         NSDate *endTime=[NSDate dateWithTimeIntervalSince1970:[dicData[@"endtime"] doubleValue]/1000];
         NSString *strTime=[NSString stringWithFormat:@"%@ 至 %@",[startTime formattedDateWithFormat:@"MM-dd hh:mm"],[endTime formattedDateWithFormat:@"MM-dd hh:mm"]];
         
       return  @{
           kActivityDetailID:dicData[@"id"],
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
