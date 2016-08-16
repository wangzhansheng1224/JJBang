//
//  MyRechargeAPIManager.m
//  jjb_user
//
//  Created by Maybe on 16/8/12.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyRechargeAPIManager.h"

@interface MyRechargeAPIManager ()


@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation MyRechargeAPIManager


#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"gateway/0/unifiedorder";
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
    static dispatch_once_t MyRechargeAPIManagerOnceToken;
    static MyRechargeAPIManager *sharedInstance = nil;
    dispatch_once(&MyRechargeAPIManagerOnceToken, ^{
        sharedInstance = [[MyRechargeAPIManager alloc] init];
    });
    return sharedInstance;
}

@end
