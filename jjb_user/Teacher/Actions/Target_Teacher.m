//
//  Target_Teacher.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "Target_Teacher.h"
#import "TeacherListController.h"
#import "TeacherController.h"

@implementation Target_Teacher
- (id)Action_TeacherList:(NSDictionary *)params{
    TeacherListController *list=[[TeacherListController alloc] init];
    return list;
}
- (id)Action_TeacherDetail:(NSDictionary *)params{
    TeacherController *detail=[[TeacherController alloc] init];
    detail.teacherID=[params[@"teacherID"] integerValue];
    return detail;
}
@end
