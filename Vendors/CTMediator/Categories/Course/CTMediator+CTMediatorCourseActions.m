//
//  CTMediator+CTMediatorCourseActions.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator+CTMediatorCourseActions.h"
NSString * const kCTMediatorCourseTarget = @"Course";
NSString * const kCTMediatorActionNativeCourseDetail = @"CourseDetail";
NSString * const kCTMediatorActionNativeCourseList = @"CourseList";


@implementation CTMediator (CTMediatorCourseActions)
- (UIViewController *)CTMediator_CourseDetail:(NSDictionary *)params{
    return [self performTarget:kCTMediatorCourseTarget
                        action:kCTMediatorActionNativeCourseDetail
                        params:params];
}
- (UIViewController *)CTMediator_CourseList:(NSDictionary *)params{
    return [self performTarget:kCTMediatorCourseTarget
                        action:kCTMediatorActionNativeCourseList
                        params:params];
}
@end
