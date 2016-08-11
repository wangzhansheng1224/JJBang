//
//  ShopIndexAPIManager.m
//  jjb_user
//
//  Created by Aimee on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityRegisterAPIManager.h"

@interface ActivityRegisterAPIManager ()
@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation ActivityRegisterAPIManager


#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"activity/saveRegistActivity";
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
    
    if ([data[@"code"] isEqualToString:@"200"]) {
        return YES;
    }
    return NO;
}

- (BOOL)manager:(LDAPIBaseManager *)manager
isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t ActivityRegisterAPIManagerOnceToken;
    static ActivityRegisterAPIManager *sharedInstance = nil;
    dispatch_once(&ActivityRegisterAPIManagerOnceToken, ^{
        sharedInstance = [[ActivityRegisterAPIManager alloc] init];
    });
    return sharedInstance;
}
@end
