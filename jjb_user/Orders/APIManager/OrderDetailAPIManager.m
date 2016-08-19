//
//  OrderDetailAPIManager.m
//  jjb_user
//
//  Created by Aimee on 16/8/18.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "OrderDetailAPIManager.h"

@interface OrderDetailAPIManager ()

@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation OrderDetailAPIManager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"gateway/orderInfo/{order_no}";
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
    if (![data[@"code"] isEqualToString:@"200"]) {
        return NO;
    }
    return YES;
}

- (BOOL)manager:(LDAPIBaseManager *)manager
isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t OrderDetailAPIManagerOnceToken;
    static OrderDetailAPIManager *sharedInstance = nil;
    dispatch_once(&OrderDetailAPIManagerOnceToken, ^{
        sharedInstance = [[OrderDetailAPIManager alloc] init];
    });
    return sharedInstance;
}

@end