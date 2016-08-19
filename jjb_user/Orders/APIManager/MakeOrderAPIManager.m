//
//  MakeOrderAPIManager.m
//  jjb_user
//
//  Created by Aimee on 16/8/18.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MakeOrderAPIManager.h"

@interface MakeOrderAPIManager ()

@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation MakeOrderAPIManager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"gateway/makeOrder/{order_type}";
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
    static dispatch_once_t MakeOrderAPIManagerOnceToken;
    static MakeOrderAPIManager *sharedInstance = nil;
    dispatch_once(&MakeOrderAPIManagerOnceToken, ^{
        sharedInstance = [[MakeOrderAPIManager alloc] init];
    });
    return sharedInstance;
}

@end