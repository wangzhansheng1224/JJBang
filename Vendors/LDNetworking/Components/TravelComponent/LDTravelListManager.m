//
//  LDTravelListManager.m
//  Common
//
//  Created by Owen on 15/8/21.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDTravelListManager.h"
#import "LDNetworking.h"
@interface LDTravelListManager ()
@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;

@end

@implementation LDTravelListManager

#pragma mark - life cycle
- (instancetype)init {
  self = [super init];
  if (self) {
    _methodName = @"share/index";
    _serviceType = kLDServiceJJBUser;
    _requestType = LDAPIManagerRequestTypeRestGet;
    self.paramSource = self;
    self.validator = self;
    self.interceptor = self;
  }
  return self;
}

- (void)loadNextPage {
  if (self.isLoading) {
    return;
  }

  NSInteger totalPage = ceil(self.totalPropertyCount / 15.0f);
  if (totalPage > 1 && self.nextPageNumber <= totalPage) {
    
 [self loadData];
  }
}
#pragma mark - LDAPIManagerInterceptor
- (void)manager:(LDAPIBaseManager *)manager
    beforePerformSuccessWithResponse:(LDURLResponse *)response {
  self.totalPropertyCount =
      [response.content[@"_meta"][@"totalCount"] integerValue];
  self.nextPageNumber++;
}

- (void)beforePerformFailWithResponse:(LDURLResponse *)response {
  if (self.nextPageNumber > 0) {
    self.nextPageNumber--;
  }
}

#pragma mark - LDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager {
  return @{ @"id" : @"1" };
}

#pragma mark - LDAPIManagerValidator
- (BOOL)manager:(LDAPIBaseManager *)manager
    isCorrectWithCallBackData:(NSDictionary *)data {
  if ([data[@"items"] count] > 0) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)manager:(LDAPIBaseManager *)manager
    isCorrectWithParamsData:(NSDictionary *)data {
  /*
   我们的城市数据只有在发布前才会下载一下，然后存成Plist文件之后，再取出来放到bundle里面去。
   平时是不会调用这个API的，因此在这里把调用API的开关关闭了。
   如果需要调用API获得数据，return YES;即可。
   */
  return YES;
}
@end
