//
//  GrowingTreeListReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GrowingTreeListReformer.h"
#import "GrowingTreeListAPIManager.h"

NSString *const kGrowingTreeListID=@"GrowingTreeListID";
NSString *const kGrowingTreeListContent=@"GrowingTreeListContent";
NSString *const kGrowingTreeListLongitude=@"GrowingTreeListLongitude";
NSString *const kGrowingTreeListLatitude=@"GrowingTreeListLatitude";
NSString *const kGrowingTreeListFromUser=@"GrowingTreeListFromUser";
NSString *const kGrowingTreeListStuName=@"GrowingTreeListStuName";
NSString *const kGrowingTreeListCreateTime=@"GrowingTreeListCreateTime";
NSString *const kGrowingTreeListImagePaths=@"GrowingTreeListImagePath";


@implementation GrowingTreeListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    
    if ([manager isKindOfClass:[GrowingTreeListAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            NSDictionary *itemData=@{
                                     kGrowingTreeListID:arrData[i][@"id"],
                                     kGrowingTreeListContent:arrData[i][@"content"],
                                     kGrowingTreeListLongitude:arrData[i][@"longitude"],
                                     kGrowingTreeListLatitude:arrData[i][@"latitude"],
                                     kGrowingTreeListFromUser:arrData[i][@"fromUser"],
                                     kGrowingTreeListStuName:arrData[i][@"stuName"],
                                     kGrowingTreeListCreateTime:arrData[i][@"create_time"],
                                     kGrowingTreeListImagePaths:arrData[i][@"images"]
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}
@end