//
//  ActivityListReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityListReformer.h"
#import "ActivityListAPIManager.h"

NSString *const kActivityListID=@"ActivityListID";
NSString *const kActivityListTitle=@"ActivityListTitle";
NSString *const kActivityListDate=@"ActivityListDate";
NSString *const kActivityListAddress=@"ActivityListAddress";
NSString *const kActivityListState=@"ActivityListState";
NSString *const kActivityListImageURL=@"ActivityListImage";
NSString *const kActivityListIsRegist=@"ActivityListIsRegist";

@implementation ActivityListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[ActivityListAPIManager class]]) {
 
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            
            NSDate *startTime=[NSDate dateWithTimeIntervalSince1970:[arrData[i][@"starttime"] doubleValue]/1000];
            
            NSDate *endTime=[NSDate dateWithTimeIntervalSince1970:[arrData[i][@"endtime"] doubleValue]/1000];
            NSString *strTime=[NSString stringWithFormat:@"%@ 至 %@",[startTime formattedDateWithFormat:@"MM-dd hh:mm"],[endTime formattedDateWithFormat:@"MM-dd hh:mm"]];
            NSURL *url;
            if (arrData[i][@"image"]!=[NSNull null]) {
                url=   [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",ImageServer,arrData[i][@"image"]]];
            }
            
            NSDictionary *itemData=@{
                                     kActivityListID:arrData[i][@"id"]!=[NSNull null]?arrData[i][@"id"]:@" ",
                                     kActivityListTitle:arrData[i][@"title"]!=[NSNull null]?arrData[i][@"title"]:@" ",
                                     kActivityListDate:strTime,
                                     kActivityListAddress:arrData[i][@"address"]!=[NSNull null]?arrData[i][@"address"]:@" ",
                                     kActivityListState:arrData[i][@"state"]!=[NSNull null]?arrData[i][@"state"]:@" ",
                                     kActivityListImageURL:url?:@"",
                                     kActivityListIsRegist:arrData[i][@"isRegist"]!=[NSNull null]?arrData[i][@"isRegist"]:@" "
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}
@end
