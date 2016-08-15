//
//  Target_Student.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "Target_Student.h"
#import "StudentController.h"
#import "StudentDetailController.h"

@implementation Target_Student

- (id)Action_StudentList:(NSDictionary *)params{
    StudentController *list = [[StudentController alloc] init];
    return list;
}

- (id)Action_StudentDetail:(NSDictionary *)params{
    StudentDetailController *detail = [[StudentDetailController alloc] init];
    detail.studentID=[params[@"studentID"] integerValue];
    return detail;
}
@end
