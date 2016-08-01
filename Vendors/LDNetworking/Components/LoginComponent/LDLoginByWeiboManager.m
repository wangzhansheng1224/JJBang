//
//  LDLoginByWeiboManager.m
//  Common
//
//  Created by Owen on 15/8/26.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDLoginByWeiboManager.h"

@interface LDLoginByWeiboManager ()
@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation LDLoginByWeiboManager

#pragma mark - life cycle
- (instancetype)init {
  self = [super init];
  if (self) {
    _methodName = @"user/loginbyweibo";
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
  if (data[@"username"] != nil) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)manager:(LDAPIBaseManager *)manager
    isCorrectWithParamsData:(NSDictionary *)data {
  return YES;
}

#pragma mark - public methods
+ (instancetype)sharedInstance {
  static dispatch_once_t LDLoginByWeiboManagerOnceToken;
  static LDLoginByWeiboManager *sharedInstance = nil;
  dispatch_once(&LDLoginByWeiboManagerOnceToken, ^{
    sharedInstance = [[LDLoginByWeiboManager alloc] init];
  });
  return sharedInstance;
}

@end
