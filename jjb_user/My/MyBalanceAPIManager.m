//
//  MyBalanceAPIManager.m
//  jjb_user
//
//  Created by Maybe on 16/9/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

// 余额接口
#import "MyBalanceAPIManager.h"

@interface MyBalanceAPIManager ()


@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation MyBalanceAPIManager


#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"order/{user_id}/{type}/{start}/{count}";
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
    static dispatch_once_t MyBalanceAPIManagerOnceToken;
    static MyBalanceAPIManager *sharedInstance = nil;
    dispatch_once(&MyBalanceAPIManagerOnceToken, ^{
        sharedInstance = [[MyBalanceAPIManager alloc] init];
    });
    return sharedInstance;
}

@end
