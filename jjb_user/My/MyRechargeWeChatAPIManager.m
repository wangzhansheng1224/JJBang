//
//  MyRechargeWeChatAPIManager.m
//  jjb_user
//
//  Created by Maybe on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyRechargeWeChatAPIManager.h"
/**
 *  微信充值接口
 */


@interface MyRechargeWeChatAPIManager ()


@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation MyRechargeWeChatAPIManager


#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"gateway/1/unifiedorder";
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
    static dispatch_once_t MyRechargeWeChatAPIManagerOnceToken;
    static MyRechargeWeChatAPIManager *sharedInstance = nil;
    dispatch_once(&MyRechargeWeChatAPIManagerOnceToken, ^{
        sharedInstance = [[MyRechargeWeChatAPIManager alloc] init];
    });
    return sharedInstance;
}


@end
