//
//  GoodsDetailAPIManager.m
//  jjb_user
//
//  Created by Check on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GoodsDetailAPIManager.h"

@interface GoodsDetailAPIManager ()

@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;

@end

@implementation GoodsDetailAPIManager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"goods/selectGoodsDetail";
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
    static dispatch_once_t GoodsDetailAPIManagerOnceToken;
    static GoodsDetailAPIManager *sharedInstance = nil;
    dispatch_once(&GoodsDetailAPIManagerOnceToken, ^{
        sharedInstance = [[GoodsDetailAPIManager alloc] init];
    });
    return sharedInstance;
}

@end