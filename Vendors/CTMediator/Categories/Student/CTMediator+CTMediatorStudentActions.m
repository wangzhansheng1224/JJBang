//
//  CTMediator+CTMediatorStudentActions.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator+CTMediatorStudentActions.h"

NSString * const kCTMediatorStudentTarget = @"Student";
NSString * const kCTMediatorActionNativeStudentDetail = @"StudentDetail";
NSString * const kCTMediatorActionNativeStudentList = @"StudentList";

@implementation CTMediator (CTMediatorStudentActions)

- (UIViewController *)CTMediator_StudentDetail:(NSDictionary *)params{
    return [self performTarget:kCTMediatorStudentTarget
                        action:kCTMediatorActionNativeStudentDetail
                        params:params];
}

- (UIViewController *)CTMediator_StudentList:(NSDictionary *)params{
    return [self performTarget:kCTMediatorStudentTarget
                        action:kCTMediatorActionNativeStudentList
                        params:params];
}

@end
