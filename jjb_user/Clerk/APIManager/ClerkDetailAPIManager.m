//
//  ClerkDetailAPIManager.m
//  jjb_user
//
//  Created by Maybe on 16/8/29.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ClerkDetailAPIManager.h"

@interface ClerkDetailAPIManager ()
@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation ClerkDetailAPIManager


#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"shop/employeeinfo";
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
    if ([data[@"code"] isEqualToString:@"200"] )
        return YES;
    else
        return NO;
}

- (BOOL)manager:(LDAPIBaseManager *)manager
isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t ClerkDetailAPIManagerOnceToken;
    static ClerkDetailAPIManager *sharedInstance = nil;
    dispatch_once(&ClerkDetailAPIManagerOnceToken, ^{
        sharedInstance = [[ClerkDetailAPIManager alloc] init];
    });
    return sharedInstance;
}

@end
