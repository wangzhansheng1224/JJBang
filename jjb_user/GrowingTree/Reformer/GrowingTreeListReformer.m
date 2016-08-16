//
//  GrowingTreeListReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GrowingTreeListReformer.h"
#import "GrowingTreeListAPIManager.h"
#import "MyGrowingAPIManager.h"

NSString *const kGrowingTreeListID=@"GrowingTreeListID";
NSString *const kGrowingTreeListContent=@"GrowingTreeListContent";
NSString *const kGrowingTreeListToUserID=@"GrowingTreeListToUserID";
NSString *const kGrowingTreeListToUserName=@"GrowingTreeListToUserName";
NSString *const kGrowingTreeListToUserFace=@"GrowingTreeListToUserFace";
NSString *const kGrowingTreeListFromUserID=@"GrowingTreeListFromUserID";
NSString *const kGrowingTreeListFromUserName=@"GrowingTreeListFromUserName";
NSString *const kGrowingTreeListFromUserFace=@"GrowingTreeListFromUserFace";
NSString *const kGrowingTreeListAddress=@"GrowingTreeListAddress";
NSString *const kGrowingTreeListCreateTime=@"GrowingTreeListCreateTime";
NSString *const kGrowingTreeListImages=@"GrowingTreeListImages";
NSString *const kGrowingTreeListImagesOrderNum=@"GrowingTreeListImagesOrderNum";
NSString *const kGrowingTreeListImagesPath=@"GrowingTreeListImagesPath";

@implementation GrowingTreeListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    
    if ([manager isKindOfClass:[GrowingTreeListAPIManager class]]||[manager isKindOfClass:[MyGrowingAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            
            //当前时间
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            
            NSTimeInterval a=[dat timeIntervalSince1970];
            
            NSString*timeString = [NSString stringWithFormat:@"%0.f", a];
            //后台时间
            
            int oldTime = [arrData[i][@"create_time"]!=[NSNull null]?arrData[i][@"create_time"]:@" " doubleValue]/1000;
            int newTime = [timeString intValue];
            
            NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow: oldTime -newTime];
            
            NSArray* imagesArray= arrData[i][@"images"];
            NSMutableArray* imagesMArray=[[NSMutableArray alloc] initWithCapacity:0];
            for (NSInteger i=0; i<[imagesArray count]; i++) {
                [imagesMArray addObject:@{
                                          kGrowingTreeListImagesOrderNum:@(i),
                                          kGrowingTreeListImagesPath:imagesArray[i][@"image_path"]
                                          }];
            }
            NSDictionary *itemData=@{
                                     kGrowingTreeListID:arrData[i][@"id"]!=[NSNull null]?arrData[i][@"id"]:@" ",
                                     kGrowingTreeListContent:arrData[i][@"content"]!=[NSNull null]?arrData[i][@"content"]:@" ",
                                     kGrowingTreeListToUserID:arrData[i][@"stuId"]!=[NSNull null]?arrData[i][@"stuId"]:@" ",
                                     kGrowingTreeListToUserFace:arrData[i][@"stuUserface"]!=[NSNull null]?arrData[i][@"stuUserface"]:@" ",
                                     kGrowingTreeListToUserName:arrData[i][@"stuName"]!=[NSNull null]?arrData[i][@"stuName"]:@" ",
                                     kGrowingTreeListFromUserID:arrData[i][@"fromUserId"]!=[NSNull null]?arrData[i][@"fromUserId"]:@" ",
                                     kGrowingTreeListFromUserFace:arrData[i][@"fromUserface"]!=[NSNull null]?arrData[i][@"fromUserface"]:@" ",
                                     kGrowingTreeListFromUserName:arrData[i][@"fromUser"]!=[NSNull null]?arrData[i][@"fromUser"]:@" ",
                                     kGrowingTreeListAddress:arrData[i][@"address"]!=[NSNull null]?arrData[i][@"address"]:@" ",
                                     kGrowingTreeListCreateTime:timeAgoDate.timeAgoSinceNow,
                                     kGrowingTreeListImages:imagesMArray
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}
@end