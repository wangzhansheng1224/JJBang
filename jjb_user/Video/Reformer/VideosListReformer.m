//
//  VideosListReformer.m
//  jjb_user
//
//  Created by Check on 16/8/28.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "VideosListReformer.h"
#import "VideosListAPIManager.h"

NSString *const kVideosListID = @"VideosListID";
NSString *const kVideosListTocourseName = @"VideosListTocourseName";
NSString *const kVideosListTocourseImg = @"VideosListTocourseImg";
NSString *const kVideosListToName = @"VideosListToName";
NSString *const kVideosListToShopName = @"VideosListToShopName";
NSString *const kVideosListStartEndTime = @"VideosListStartEndTime";
NSString *const kVideosListEndTime = @"VideosListEndTime";

@implementation VideosListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    
    if ([manager isKindOfClass:[VideosListAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            
            NSDate *startTime=[NSDate dateWithTimeIntervalSince1970:[arrData[i][@"startTime"] doubleValue]/1000];
            
            NSDate *endTime=[NSDate dateWithTimeIntervalSince1970:[arrData[i][@"endTime"] doubleValue]/1000];
            NSString *startEndTime=[NSString stringWithFormat:@"%@ 至 %@",[startTime formattedDateWithFormat:@"MM-dd hh:mm"],[endTime formattedDateWithFormat:@"MM-dd hh:mm"]];
            NSURL *courseImagUrl;
            if (arrData[i][@"courseImg"]!=[NSNull null]) {
                courseImagUrl=   [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@",arrData[i][@"courseImg"]]];
            }

            NSDictionary *itemData=@{
                                     kVideosListID:arrData[i][@"id"]!=[NSNull null]?arrData[i][@"id"]:@" ",
                                     kVideosListToName:arrData[i][@"name"]!=[NSNull null]?arrData[i][@"name"]:@" ",
                                     kVideosListToShopName:arrData[i][@"shopName"]!=[NSNull null]?arrData[i][@"shopName"]:@" ",
                                     kVideosListTocourseName:arrData[i][@"courseName"]!=[NSNull null]?arrData[i][@"courseName"]:@" ",
                                     kVideosListTocourseImg:courseImagUrl,
                                     kVideosListStartEndTime:startEndTime
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
        
        
    }
    return nil;
}
@end
