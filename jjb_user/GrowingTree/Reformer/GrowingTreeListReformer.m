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
NSString *const kGrowingTreeListToUserID=@"GrowingTreeListToUserID";
NSString *const kGrowingTreeListToUserName=@"GrowingTreeListToUserName";
NSString *const kGrowingTreeListToUserFace=@"GrowingTreeListToUserFace";
NSString *const kGrowingTreeListFromUserID=@"GrowingTreeListFromUserID";
NSString *const kGrowingTreeListFromUserName=@"GrowingTreeListFromUserName";
NSString *const kGrowingTreeListFromUserFace=@"GrowingTreeListFromUserFace";
NSString *const kGrowingTreeListAddress=@"GrowingTreeListAddress";
NSString *const kGrowingTreeListCreateTime=@"GrowingTreeListCreateTime";
NSString *const kGrowingTreeListImages=@"GrowingTreeListImages";

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
                                     kGrowingTreeListToUserID:arrData[i][@"stuId"],
                                     kGrowingTreeListToUserFace:arrData[i][@"stuUserface"],
                                     kGrowingTreeListToUserName:arrData[i][@"stuName"],
                                     kGrowingTreeListFromUserID:arrData[i][@"fromUserId"],
                                     kGrowingTreeListFromUserFace:arrData[i][@"fromUserface"],
                                     kGrowingTreeListFromUserName:arrData[i][@"fromUser"],
                                     kGrowingTreeListAddress:arrData[i][@"address"],
                                     kGrowingTreeListCreateTime:arrData[i][@"create_time"],
                                     kGrowingTreeListImages:arrData[i][@"images"]
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}
@end