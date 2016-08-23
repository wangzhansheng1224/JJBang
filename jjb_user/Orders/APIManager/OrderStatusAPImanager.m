//
//  OrderStatusAPImanager.m
//  jjb_user
//
//  Created by Aimee on 16/8/23.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "OrderStatusAPImanager.h"

@interface OrderStatusAPImanager ()

@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation OrderStatusAPImanager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
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
    static dispatch_once_t OrderStatusAPImanagerOnceToken;
    static OrderStatusAPImanager *sharedInstance = nil;
    dispatch_once(&OrderStatusAPImanagerOnceToken, ^{
        sharedInstance = [[OrderStatusAPImanager alloc] init];
    });
    return sharedInstance;
}




@end
