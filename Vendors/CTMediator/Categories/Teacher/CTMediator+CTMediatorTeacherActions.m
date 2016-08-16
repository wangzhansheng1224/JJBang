//
//  CTMediator+CTMediatorTeacherActions.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator+CTMediatorTeacherActions.h"
NSString * const kCTMediatorTeacherTarget = @"Teacher";
NSString * const kCTMediatorActionNativeTeacherDetail = @"TeacherDetail";
NSString * const kCTMediatorActionNativeTeacherList = @"TeacherList";
NSString * const kCTMediatorActionNativeStarTeacherList = @"StrTeacherList";

@implementation CTMediator (CTMediatorTeacherActions)
- (UIViewController *)CTMediator_TeacherDetail:(NSDictionary *)params{
    return [self performTarget:kCTMediatorTeacherTarget
                        action:kCTMediatorActionNativeTeacherDetail
                        params:params];
}
- (UIViewController *)CTMediator_TeacherList:(NSDictionary *)params{
    return [self performTarget:kCTMediatorTeacherTarget
                        action:kCTMediatorActionNativeTeacherList
                        params:params];
}
- (UIViewController *)CTMediator_StarTeacherList:(NSDictionary *)params{
    return [self performTarget:kCTMediatorTeacherTarget
                        action:kCTMediatorActionNativeStarTeacherList
                        params:params];
}
@end
