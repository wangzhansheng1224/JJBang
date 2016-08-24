//
//  FirstShopIndexAPIManager.m
//  jjb_user
//
//  Created by Maybe on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "FirstShopIndexAPIManager.h"

@interface FirstShopIndexAPIManager ()
@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation FirstShopIndexAPIManager


#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"home/list";
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
    static dispatch_once_t FirstShopIndexAPIManagerOnceToken;
    static FirstShopIndexAPIManager *sharedInstance = nil;
    dispatch_once(&FirstShopIndexAPIManagerOnceToken, ^{
        sharedInstance = [[FirstShopIndexAPIManager alloc] init];
    });
    return sharedInstance;
}


@end
