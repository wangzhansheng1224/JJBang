//
//  UpdateFamilyAPIManager.m
//  jjb_user
//
//  Created by Owen on 16/9/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "UpdateFamilyAPIManager.h"

@interface UpdateFamilyAPIManager ()

@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;

@end

@implementation UpdateFamilyAPIManager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"family/updateFamilyMember";
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
    static dispatch_once_t UpdateFamilyAPIManagerOnceToken;
    static UpdateFamilyAPIManager *sharedInstance = nil;
    dispatch_once(&UpdateFamilyAPIManagerOnceToken, ^{
        sharedInstance = [[UpdateFamilyAPIManager alloc] init];
    });
    return sharedInstance;
}

@end
