//
//  changeMyInfoAPIManager.m
//  jjb_user
//
//  Created by Maybe on 16/9/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "changeMyInfoAPIManager.h"

@interface changeMyInfoAPIManager ()
@property(nonatomic, copy) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation changeMyInfoAPIManager
#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"user/edit";
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
    static dispatch_once_t changeMyInfoAPIManagerOnceToken;
    static changeMyInfoAPIManager *sharedInstance = nil;
    dispatch_once(&changeMyInfoAPIManagerOnceToken, ^{
        sharedInstance = [[changeMyInfoAPIManager alloc] init];
    });
    return sharedInstance;
}


@end
