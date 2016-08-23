//
//  MBOrderPayTypeAPIManager.m
//  jjb_user
//
//  Created by Maybe on 16/8/22.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//
// 支付方式


#import "MBOrderPayTypeAPIManager.h"

@interface MBOrderPayTypeAPIManager ()

@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation MBOrderPayTypeAPIManager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"gateway/orderPayWay/{way}/{order_no}/{user_id}";
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
    static dispatch_once_t MBOrderPayTypeAPIManagerOnceToken;
    static MBOrderPayTypeAPIManager *sharedInstance = nil;
    dispatch_once(&MBOrderPayTypeAPIManagerOnceToken, ^{
        sharedInstance = [[MBOrderPayTypeAPIManager alloc] init];
    });
    return sharedInstance;
}




@end
