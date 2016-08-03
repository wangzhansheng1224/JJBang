//
//  TeacherInfoAPIManager.m
//  jjb_user
//
//  Created by Aimee on 16/8/3.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TeacherInfoAPIManager.h"

@interface TeacherInfoAPIManager ()
@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation TeacherInfoAPIManager


#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"grown/teacherInfo";
        _serviceType = kLDServiceJJBUser;
        _requestType = LDAPIManagerRequestTypePost;
        self.validator = self;
        self.interceptor = self;
    }
    return self;
}

#pragma mark - LDAPIManagerValidator
- (BOOL)manager:(LDAPIBaseManager *)manager
isCorrectWithCallBackData:(NSDictionary *)data {
    return YES;
}

- (BOOL)manager:(LDAPIBaseManager *)manager
isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t TeacherInfoAPIManagerOnceToken;
    static TeacherInfoAPIManager *sharedInstance = nil;
    dispatch_once(&TeacherInfoAPIManagerOnceToken, ^{
        sharedInstance = [[TeacherInfoAPIManager alloc] init];
    });
    return sharedInstance;
}

@end