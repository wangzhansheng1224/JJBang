//
//  Target_Course.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "Target_Course.h"
#import "CourseListController.h"
#import "CourseController.h"

@implementation Target_Course
- (id)Action_CourseList:(NSDictionary *)params{
    CourseListController *list=[[CourseListController alloc] init];
    return list;
}
- (id)Action_CourseDetail:(NSDictionary *)params{
    CourseController *detail=[[CourseController alloc] init];
    detail.courseID=[params[@"courseID"] integerValue];
    return detail;
}
@end
