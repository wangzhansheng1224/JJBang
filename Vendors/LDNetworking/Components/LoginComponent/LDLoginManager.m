//
//  LDLoginManager.m
//  Common
//
//  Created by Owen on 15/8/25.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDLoginManager.h"
#import "LDNetworking.h"
@interface LDLoginManager ()
@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation LDLoginManager

#pragma mark - life cycle
- (instancetype)init {
  self = [super init];
  if (self) {
    _methodName = @"user/login";
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
  static dispatch_once_t LDLoginManagerOnceToken;
  static LDLoginManager *sharedInstance = nil;
  dispatch_once(&LDLoginManagerOnceToken, ^{
    sharedInstance = [[LDLoginManager alloc] init];
  });
  return sharedInstance;
}
@end
