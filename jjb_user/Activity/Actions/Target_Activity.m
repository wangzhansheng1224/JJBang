//
//  Target_Activity.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "Target_Activity.h"
#import "ActivityDetailController.h"
#import "HomePageActivityController.h"

@implementation Target_Activity
- (id)Action_ActivityDetail:(NSDictionary *)params{
    ActivityDetailController *detail = [[ActivityDetailController alloc] init];
    detail.activity_id=[params[@"activityID"] integerValue];
    return detail;
}

- (id)Action_ActivityList:(NSDictionary *)params{
    HomePageActivityController *list = [[HomePageActivityController alloc] init];
    return list;
}
@end
