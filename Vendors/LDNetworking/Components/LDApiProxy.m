//
//  APIProxy.m
//  Common
//
//  Created by Owen on 15/8/21.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDApiProxy.h"
#import <AFNetworking/AFNetworking.h>
#import "LDServiceFactory.h"
#import "NSURLRequest+LDNetworkingMethods.h"
#import "LDRequestGenerator.h"
#import "LDLogger.h"

@interface LDApiProxy ()

@property(nonatomic, strong) NSMutableDictionary *dispatchTable;
@property(nonatomic, strong) NSNumber *recordedRequestId;

// AFNetworking stuff
@property(nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end
@implementation LDApiProxy
#pragma mark - getters and setters
- (NSMutableDictionary *)dispatchTable {
  if (_dispatchTable == nil) {
    _dispatchTable = [[NSMutableDictionary alloc] init];
  }
  return _dispatchTable;
}

- (AFHTTPRequestOperationManager *)operationManager {
  if (_operationManager == nil) {
    _operationManager =
        [[AFHTTPRequestOperationManager alloc] initWithBaseURL:nil];
    _operationManager.responseSerializer =
        [AFHTTPResponseSerializer serializer];
  }
  return _operationManager;
}
#pragma mark - life cycle
+ (instancetype)sharedInstance {
  static dispatch_once_t onceToken;
  static LDApiProxy *sharedInstance = nil;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[LDApiProxy alloc] init];
  });
  return sharedInstance;
}

#pragma mark - public methods
- (NSInteger)callGETWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(LDCallback)success
                          fail:(LDCallback)fail {
  NSURLRequest *request = [[LDRequestGenerator sharedInstance]
      generateGETRequestWithServiceIdentifier:servieIdentifier
                                requestParams:params
                                   methodName:methodName];
  NSNumber *requestId =
      [self callApiWithRequest:request success:success fail:fail];
  return [requestId integerValue];
}

- (NSInteger)callPOSTWithParams:(NSDictionary *)params
              serviceIdentifier:(NSString *)servieIdentifier
                     methodName:(NSString *)methodName
                        success:(LDCallback)success
                           fail:(LDCallback)fail {
  NSURLRequest *request = [[LDRequestGenerator sharedInstance]
      generatePOSTRequestWithServiceIdentifier:servieIdentifier
                                 requestParams:params
                                    methodName:methodName];
  NSNumber *requestId =
      [self callApiWithRequest:request success:success fail:fail];
  return [requestId integerValue];
}

- (NSInteger)callRestfulGETWithParams:(NSDictionary *)params
                    serviceIdentifier:(NSString *)servieIdentifier
                           methodName:(NSString *)methodName
                              success:(LDCallback)success
                                 fail:(LDCallback)fail {
  NSURLRequest *request = [[LDRequestGenerator sharedInstance]
      generateRestfulGETRequestWithServiceIdentifier:servieIdentifier
                                       requestParams:params
                                          methodName:methodName];
  NSNumber *requestId =
      [self callApiWithRequest:request success:success fail:fail];
  return [requestId integerValue];
}

- (NSInteger)callRestfulPOSTWithParams:(NSDictionary *)params
                     serviceIdentifier:(NSString *)servieIdentifier
                            methodName:(NSString *)methodName
                               success:(LDCallback)success
                                  fail:(LDCallback)fail {
  NSURLRequest *request = [[LDRequestGenerator sharedInstance]
      generateRestfulPOSTRequestWithServiceIdentifier:servieIdentifier
                                        requestParams:params
                                           methodName:methodName];
  NSNumber *requestId =
      [self callApiWithRequest:request success:success fail:fail];
  return [requestId integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID {
  NSOperation *requestOperation = self.dispatchTable[requestID];
  [requestOperation cancel];
  [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList {
  for (NSNumber *requestId in requestIDList) {
    [self cancelRequestWithRequestID:requestId];
  }
}

#pragma mark - private methods
/**
 * 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。
 */
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request
                         success:(LDCallback)success
                            fail:(LDCallback)fail {
  // 之所以不用getter，是因为如果放到getter里面的话，每次调用self.recordedRequestId的时候值就都变了，违背了getter的初衷
  NSNumber *requestId = [self generateRequestId];

  // 跑到这里的block的时候，就已经是主线程了。
  AFHTTPRequestOperation *httpRequestOperation =
      [self.operationManager HTTPRequestOperationWithRequest:request
          success:^(AFHTTPRequestOperation *operation, id responseObject) {

            AFHTTPRequestOperation *storedOperation =
                self.dispatchTable[requestId];
            if (storedOperation == nil) {
              // 如果这个operation是被cancel的，那就不用处理回调了。
              return;
            } else {
              [self.dispatchTable removeObjectForKey:requestId];
            }

            [LDLogger logDebugInfoWithResponse:operation.response
                                 resposeString:operation.responseString
                                       request:operation.request
                                         error:NULL];

            LDURLResponse *response = [[LDURLResponse alloc]
                initWithResponseString:operation.responseString
                             requestId:requestId
                               request:operation.request
                          responseData:operation.responseData
                                status:LDURLResponseStatusSuccess];
            success ? success(response) : nil;

          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            AFHTTPRequestOperation *storedOperation =
                self.dispatchTable[requestId];
            if (storedOperation == nil) {
              // 如果这个operation是被cancel的，那就不用处理回调了。
              return;
            } else {
              [self.dispatchTable removeObjectForKey:requestId];
            }
            [LDLogger logDebugInfoWithResponse:operation.response
                                 resposeString:operation.responseString
                                       request:operation.request
                                         error:error];

            LDURLResponse *response = [[LDURLResponse alloc]
                initWithResponseString:operation.responseString
                             requestId:requestId
                               request:operation.request
                          responseData:operation.responseData
                                 error:error];
            fail ? fail(response) : nil;

          }];

  self.dispatchTable[requestId] = httpRequestOperation;
  [[self.operationManager operationQueue] addOperation:httpRequestOperation];
  return requestId;
}

- (NSNumber *)generateRequestId {
  if (_recordedRequestId == nil) {
    _recordedRequestId = @(1);
  } else {
    if ([_recordedRequestId integerValue] == NSIntegerMax) {
      _recordedRequestId = @(1);
    } else {
      _recordedRequestId = @([_recordedRequestId integerValue] + 1);
    }
  }
  return _recordedRequestId;
}

@end
