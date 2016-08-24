//
//  StudentDetailAPIManager.m
//  jjb_user
//
//  Created by Aimee on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StudentDetailAPIManager.h"
@interface StudentDetailAPIManager ()

@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;

@end

@implementation StudentDetailAPIManager


#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"user/selectStudentDetail";
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
    if ([data objectForKey:@"stuId"] ==nil) {
        return NO;
    }
    return YES;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t StudentDetailAPIManagerOnceToken;
    static StudentDetailAPIManager *sharedInstance = nil;
    dispatch_once(&StudentDetailAPIManagerOnceToken, ^{
        sharedInstance = [[StudentDetailAPIManager alloc] init];
    });
    return sharedInstance;
}

@end
