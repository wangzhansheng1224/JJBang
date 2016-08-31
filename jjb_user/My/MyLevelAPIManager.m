//
//  MyLevelAPIManager.m
//  jjb_user
//
//  Created by Maybe on 16/8/31.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyLevelAPIManager.h"

@interface MyLevelAPIManager ()
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation MyLevelAPIManager


#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"user/level";
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
    static dispatch_once_t MyLevelAPIManagerOnceToken;
    static MyLevelAPIManager *sharedInstance = nil;
    dispatch_once(&MyLevelAPIManagerOnceToken, ^{
        sharedInstance = [[MyLevelAPIManager alloc] init];
    });
    return sharedInstance;
}

@end
