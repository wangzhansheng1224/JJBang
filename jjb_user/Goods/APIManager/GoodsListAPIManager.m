//
//  GoodsListAPIManager.m
//  jjb_user
//
//  Created by Check on 16/8/15.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GoodsListAPIManager.h"

@interface GoodsListAPIManager ()

@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;

@end

@implementation GoodsListAPIManager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"goods/selectGoodsPage";
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
    static dispatch_once_t GoodsListAPIManagerOnceToken;
    static GoodsListAPIManager *sharedInstance = nil;
    dispatch_once(&GoodsListAPIManagerOnceToken, ^{
        sharedInstance = [[GoodsListAPIManager alloc] init];
    });
    return sharedInstance;
}

@end
