//
//  APIBaseManager.m
//  Common
//
//  Created by Owen on 15/8/20.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDAPIBaseManager.h"
#import "LDNetworking.h"
#import "LDCache.h"
#import "LDLogger.h"
#import "LDServiceFactory.h"

#define LDCallAPI(REQUEST_METHOD, REQUEST_PARAMS, REQUEST_ID)                  \
  {                                                                            \
    REQUEST_ID = [[LDApiProxy sharedInstance] call##REQUEST_METHOD##           \
        WithParams:REQUEST_PARAMS                                              \
        serviceIdentifier:self.child.serviceType                               \
        methodName:self.child.methodName                                       \
        success:^(LDURLResponse * response) {                                  \
      [self successedOnCallingAPI:response];                                   \
        }                                                                      \
        fail:^(LDURLResponse * response) {                                     \
      LDAPIManagerErrorType eType = LDAPIManagerErrorTypeDefault;              \
      if (response.status == LDURLResponseStatusErrorNoNetwork) {              \
        eType = LDAPIManagerErrorTypeNoNetWork;                                \
      }                                                                        \
      if (response.status == LDURLResponseStatusErrorTimeout) {                \
        eType = LDAPIManagerErrorTypeTimeout;                                  \
      }                                                                        \
      if (response.status == LDURLResponseStatusErrorUnauthorized) {           \
        eType = LDAPIManagerErrorTypeUnauthorized;                             \
      }                                                                        \
      if (response.status == LDURLResponseStatusErrorNotFound) {               \
        eType = LDAPIManagerErrorTypeNotFound;                                 \
      }                                                                        \
      [self failedOnCallingAPI:response withErrorType:eType];                  \
        }];                                                                    \
    [self.requestIdList addObject:@(REQUEST_ID)];                              \
  }

@interface LDAPIBaseManager ()
@property (nonatomic, strong, readwrite) id fetchedRawData;
@property(nonatomic, copy, readwrite) NSString *errorMessage;
@property(nonatomic, readwrite) LDAPIManagerErrorType errorType;
@property(nonatomic, strong) NSMutableArray *requestIdList;
@property(nonatomic, strong) LDCache *cache;
@end
@implementation LDAPIBaseManager

#pragma mark - getters and setters
- (LDCache *)cache {
  if (_cache == nil) {
    _cache = [LDCache sharedInstance];
  }
  return _cache;
}

- (NSMutableArray *)requestIdList {
  if (_requestIdList == nil) {
    _requestIdList = [[NSMutableArray alloc] init];
  }
  return _requestIdList;
}
- (BOOL)isReachable {
  BOOL isReachability = [LDAppContext sharedInstance].isReachable;
  if (!isReachability) {
    self.errorType = LDAPIManagerErrorTypeNoNetWork;
  }
  return isReachability;
}
- (BOOL)isLoading {
  return [self.requestIdList count] > 0;
}

#pragma mark - life cycle
- (instancetype)init {
  self = [super init];
  if (self) {
    _delegate = nil;
    _validator = nil;
    _paramSource = nil;
    _errorMessage = nil;
    _errorType = LDAPIManagerErrorTypeDefault;
    if ([self conformsToProtocol:@protocol(LDAPIManager)]) {
      self.child = (id<LDAPIManager>)self;
    }
  }
  return self;
}

- (void)dealloc {
  [self cancelAllRequests];
  self.requestIdList = nil;
}

#pragma mark - public methods
- (void)cancelAllRequests {
  [[LDApiProxy sharedInstance]
      cancelRequestWithRequestIDList:self.requestIdList];
  [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID {
  [self removeRequestIdWithRequestID:requestID];
  [[LDApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

- (id)fetchDataWithReformer:(id<ReformerProtocol>)reformer
{
    
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}

#pragma mark - calling api
- (NSInteger)loadData {
    
    
    
  NSDictionary *params = [self.paramSource paramsForApi:self];
    
  NSInteger requestId = [self loadDataWithParams:params];
    
  return requestId;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params {
  NSInteger requestId = 0;
  NSDictionary *apiParams = [self reformParams:params];
  if ([self shouldCallAPIWithParams:apiParams]) {
    if ([self.validator manager:self isCorrectWithParamsData:apiParams]) {

      // 先检查一下是否有缓存
      if ([self shouldCache] && [self hasCacheWithParams:apiParams]) {
        return 0;
      }

      // 实际的网络请求
      if ([self isReachable]) {
        switch (self.child.requestType) {
        case LDAPIManagerRequestTypeGet:

          LDCallAPI(GET, apiParams, requestId);
          break;
        case LDAPIManagerRequestTypePost:
          LDCallAPI(POST, apiParams, requestId);
          break;
        case LDAPIManagerRequestTypeRestGet:
          LDCallAPI(RestfulGET, apiParams, requestId);
          break;
        case LDAPIManagerRequestTypeRestPost:
          LDCallAPI(RestfulPOST, apiParams, requestId);
          break;
        default:
          break;
        }

        NSMutableDictionary *params = [apiParams mutableCopy];
        params[kLDAPIBaseManagerRequestID] = @(requestId);
        [self afterCallingAPIWithParams:params];
        return requestId;

      } else {
        [self failedOnCallingAPI:nil
                   withErrorType:LDAPIManagerErrorTypeNoNetWork];
        return requestId;
      }
    } else {
      [self failedOnCallingAPI:nil
                 withErrorType:LDAPIManagerErrorTypeParamsError];
      return requestId;
    }
  }
  return requestId;
}

#pragma mark - api callbacks
- (void)apiCallBack:(LDURLResponse *)response {
  if (response.status == LDURLResponseStatusSuccess) {
    [self successedOnCallingAPI:response];
  } else {
    [self failedOnCallingAPI:response
               withErrorType:LDAPIManagerErrorTypeTimeout];
  }
}

- (void)successedOnCallingAPI:(LDURLResponse *)response {
  if (response.content) {
    self.fetchedRawData = [response.content copy];
  } else {
    self.fetchedRawData = [response.responseData copy];
  }
  [self removeRequestIdWithRequestID:response.requestId];
  if ([self.validator manager:self
          isCorrectWithCallBackData:response.content]) {

    if (kLDShouldCache && !response.isCache) {
      [self.cache saveCacheWithData:response.responseData
                  serviceIdentifier:self.child.serviceType
                         methodName:self.child.methodName
                      requestParams:response.requestParams];
    }

    [self beforePerformSuccessWithResponse:response];
    [self.delegate apiManagerCallDidSuccess:self];
    [self afterPerformSuccessWithResponse:response];
  } else {
    [self failedOnCallingAPI:response
               withErrorType:LDAPIManagerErrorTypeServiceError];
  }
}

- (void)failedOnCallingAPI:(LDURLResponse *)response
             withErrorType:(LDAPIManagerErrorType)errorType {
  self.errorType = errorType;
  [self removeRequestIdWithRequestID:response.requestId];
  [self beforePerformFailWithResponse:response];
  [self.delegate apiManagerCallDidFailed:self];
  [self afterPerformFailWithResponse:response];
}

#pragma mark - method for interceptor

/*
 拦截器的功能可以由子类通过继承实现，也可以由其它对象实现,两种做法可以共存
 当两种情况共存的时候，子类重载的方法一定要调用一下super
 然后它们的调用顺序是BaseManager会先调用子类重载的实现，再调用外部interceptor的实现

 notes:
 正常情况下，拦截器是通过代理的方式实现的，因此可以不需要以下这些代码
 但是为了将来拓展方便，如果在调用拦截器之前manager又希望自己能够先做一些事情，所以这些方法还是需要能够被继承重载的
 所有重载的方法，都要调用一下super,这样才能保证外部interceptor能够被调到
 这就是decorate pattern
 */
- (void)beforePerformSuccessWithResponse:(LDURLResponse *)response {
  self.errorType = LDAPIManagerErrorTypeSuccess;
  if ([self.interceptor
          respondsToSelector:@selector(manager:
                                 beforePerformSuccessWithResponse:)]) {
    [self.interceptor manager:self beforePerformSuccessWithResponse:response];
  }
}

- (void)afterPerformSuccessWithResponse:(LDURLResponse *)response {
  if ([self.interceptor
          respondsToSelector:@selector(manager:
                                 afterPerformSuccessWithResponse:)]) {
    [self.interceptor manager:self afterPerformSuccessWithResponse:response];
  }
}

- (void)beforePerformFailWithResponse:(LDURLResponse *)response {
  if ([self.interceptor
          respondsToSelector:@selector(manager:
                                 beforePerformFailWithResponse:)]) {
    [self.interceptor manager:self beforePerformFailWithResponse:response];
  }
}

- (void)afterPerformFailWithResponse:(LDURLResponse *)response {
  if ([self.interceptor
          respondsToSelector:@selector(manager:
                                 afterPerformFailWithResponse:)]) {
    [self.interceptor manager:self afterPerformFailWithResponse:response];
  }
}

//只有返回YES才会继续调用API
- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params {
  if ([self.interceptor
          respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
    return [self.interceptor manager:self shouldCallAPIWithParams:params];
  } else {
    return YES;
  }
}

- (void)afterCallingAPIWithParams:(NSDictionary *)params {
  if ([self.interceptor
          respondsToSelector:@selector(manager:afterCallingAPIWithParams:)]) {
    [self.interceptor manager:self afterCallingAPIWithParams:params];
  }
}

#pragma mark - method for child
- (void)cleanData {
  IMP childIMP = [self.child methodForSelector:@selector(cleanData)];
  IMP selfIMP = [self methodForSelector:@selector(cleanData)];

  if (childIMP == selfIMP) {
    self.fetchedRawData = nil;
    self.errorMessage = nil;
    self.errorType = LDAPIManagerErrorTypeDefault;
  } else {
    if ([self.child respondsToSelector:@selector(cleanData)]) {
      [self.child cleanData];
    }
  }
}

//如果需要在调用API之前额外添加一些参数，比如pageNumber和pageSize之类的就在这里添加
//子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
- (NSDictionary *)reformParams:(NSDictionary *)params {
  IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
  IMP selfIMP = [self methodForSelector:@selector(reformParams:)];

  if (childIMP == selfIMP) {
    return params;
  } else {
    // 如果child是继承得来的，那么这里就不会跑到，会直接跑子类中的IMP。
    // 如果child是另一个对象，就会跑到这里
    NSDictionary *result = nil;
    result = [self.child reformParams:params];
    if (result) {
      return result;
    } else {
      return params;
    }
  }
}

- (BOOL)shouldCache {
  return kLDShouldCache;
}
#pragma mark - private methods
- (void)removeRequestIdWithRequestID:(NSInteger)requestId {
  NSNumber *requestIDToRemove = nil;
  for (NSNumber *storedRequestId in self.requestIdList) {
    if ([storedRequestId integerValue] == requestId) {
      requestIDToRemove = storedRequestId;
    }
  }
  if (requestIDToRemove) {
    [self.requestIdList removeObject:requestIDToRemove];
  }
}

- (BOOL)hasCacheWithParams:(NSDictionary *)params {
  NSString *serviceIdentifier = self.child.serviceType;
  NSString *methodName = self.child.methodName;
  NSData *result =
      [self.cache fetchCachedDataWithServiceIdentifier:serviceIdentifier
                                            methodName:methodName
                                         requestParams:params];

  if (result == nil) {
    return NO;
  }

  dispatch_async(dispatch_get_main_queue(), ^{
    LDURLResponse *response = [[LDURLResponse alloc] initWithData:result];
    response.requestParams = params;
    [LDLogger logDebugInfoWithCachedResponse:response
                                  methodName:methodName
                           serviceIdentifier:
                               [[LDServiceFactory sharedInstance]
                                   serviceWithIdentifier:serviceIdentifier]];
    [self successedOnCallingAPI:response];
  });
  return YES;
}

@end
