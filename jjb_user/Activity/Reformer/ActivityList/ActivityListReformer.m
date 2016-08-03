//
//  ActivityListReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityListReformer.h"
#import "ActivityListAPIManager.h"
#import "ActivityListCell.h"

NSString *const kActivityListID=@"ActivityListID";
NSString *const kActivityListTitle=@"ActivityListTitle";
NSString *const kActivityListStarttime=@"ActivityListStarttime";
NSString *const kActivityListEndtime=@"ActivityListEndtime";
NSString *const kActivityListAddress=@"ActivityListAddress";
NSString *const kActivityListState=@"ActivityListState";
NSString *const kActivityListImage=@"ActivityListImage";
NSString *const kActivityListIsRegist=@"ActivityListIsRegist";

static NSString  *const ActivityListCellIdentifier=@"ActivityListCellIdentifier";

@implementation ActivityListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    
    if ([manager isKindOfClass:[ActivityListAPIManager class]]) {
 
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            NSDictionary *itemData=@{
                                     kActivityListID:arrData[i][@"id"],
                                     kActivityListTitle:arrData[i][@"title"],
                                     kActivityListStarttime:arrData[i][@"starttime"],
                                     kActivityListEndtime:arrData[i][@"endtime"],
                                     kActivityListAddress:arrData[i][@""]
                                     };
            
            ActivityListCell *cell=[[ActivityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActivityListCellIdentifier];
        }
    }

    
    NSDictionary *resultData = nil;
    
    if ([manager isKindOfClass:[ActivityListAPIManager class]]) {
        resultData = @{
                       kActivityListID:data[@"id"],
                       kActivityListTitle:data[@"title"],
                       kActivityListStarttime:data[@"title"],
                       kActivityListEndtime:data[@"title"]
                       };
    }
    return nil;
}
@end