//
//  AXRequestGenerator.m
//  RTNetworking
//
//  Created by casa on 14-5-14.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "LDRequestGenerator.h"
#import "LDSignatureGenerator.h"
#import "LDServiceFactory.h"
#import "LDCommonParamsGenerator.h"
#import "NSDictionary+LDNetworkingMethods.h"
#import "LDNetworkingConfiguration.h"
#import "NSObject+LDNetworkingMethods.h"
#import <AFNetworking/AFNetworking.h>
#import "LDService.h"
#import "NSObject+LDNetworkingMethods.h"
#import "NSURLRequest+LDNetworkingMethods.h"
#import "LDLogger.h"

@interface LDRequestGenerator ()

@property(nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation LDRequestGenerator

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer {
  if (_httpRequestSerializer == nil) {
    _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    _httpRequestSerializer.timeoutInterval = kLDNetworkingTimeoutSeconds;
    _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
  }
  return _httpRequestSerializer;
}

#pragma mark - public methods
+ (instancetype)sharedInstance {
  static dispatch_once_t onceToken;
  static LDRequestGenerator *sharedInstance = nil;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[LDRequestGenerator alloc] init];
  });
  return sharedInstance;
}

- (NSURLRequest *)
generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                          requestParams:(NSDictionary *)requestParams
                             methodName:(NSString *)methodName {
  LDService *service = [[LDServiceFactory sharedInstance]
      serviceWithIdentifier:serviceIdentifier];

  NSMutableDictionary *sigParams =
      [NSMutableDictionary dictionaryWithDictionary:requestParams];
  sigParams[@"api_key"] = service.publicKey;
  NSString *signature =
      [LDSignatureGenerator signGetWithSigParams:sigParams
                                      methodName:methodName
                                      apiVersion:service.apiVersion
                                      privateKey:service.privateKey
                                       publicKey:service.publicKey];

  NSMutableDictionary *allParams = [NSMutableDictionary
      dictionaryWithDictionary:[LDCommonParamsGenerator
                                       commonParamsDictionary]];
  [allParams addEntriesFromDictionary:sigParams];
  NSString *urlString = [NSString
      stringWithFormat:@"%@%@/%@?%@&sig=%@", service.apiBaseUrl,
                       service.apiVersion, methodName,
                       [allParams LD_urlParamsStringSignature:NO], signature];

  NSMutableURLRequest *request =
      [self.httpRequestSerializer requestWithMethod:@"GET"
                                          URLString:urlString
                                         parameters:nil
                                              error:NULL];
  request.timeoutInterval = kLDNetworkingTimeoutSeconds;
  request.requestParams = requestParams;
  [LDLogger logDebugInfoWithRequest:request
                            apiName:methodName
                            service:service
                      requestParams:requestParams
                         httpMethod:@"GET"];
  return request;
}

- (NSURLRequest *)
generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                           requestParams:(NSDictionary *)requestParams
                              methodName:(NSString *)methodName {
  LDService *service = [[LDServiceFactory sharedInstance]
      serviceWithIdentifier:serviceIdentifier];
  NSString *signature =
      [LDSignatureGenerator signPostWithApiParams:requestParams
                                       privateKey:service.privateKey
                                        publicKey:service.publicKey];
  NSString *urlString = [NSString
      stringWithFormat:@"%@%@/%@?api_key=%@&sig=%@&%@", service.apiBaseUrl,
                       service.apiVersion, methodName, service.publicKey,
                       signature,
                       [[LDCommonParamsGenerator commonParamsDictionary]
                           LD_urlParamsStringSignature:NO]];

  NSURLRequest *request =
      [self.httpRequestSerializer requestWithMethod:@"POST"
                                          URLString:urlString
                                         parameters:requestParams
                                              error:NULL];
  request.requestParams = requestParams;
  [LDLogger logDebugInfoWithRequest:request
                            apiName:methodName
                            service:service
                      requestParams:requestParams
                         httpMethod:@"POST"];
  return request;
}

- (NSURLRequest *)
generateRestfulGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                 requestParams:(NSDictionary *)requestParams
                                    methodName:(NSString *)methodName {
  NSMutableDictionary *allParams = [NSMutableDictionary
      dictionaryWithDictionary:[LDCommonParamsGenerator
                                       commonParamsDictionary]];
  [allParams addEntriesFromDictionary:requestParams];

  LDService *service = [[LDServiceFactory sharedInstance]
      serviceWithIdentifier:serviceIdentifier];
  NSString *signature =
      [LDSignatureGenerator signRestfulGetWithAllParams:allParams
                                             methodName:methodName
                                             apiVersion:service.apiVersion
                                             privateKey:service.privateKey];
  NSString *urlString = [NSString
      stringWithFormat:@"%@%@/%@?%@", service.apiBaseUrl, service.apiVersion,
                       methodName, [allParams LD_urlParamsStringSignature:NO]];

  NSDictionary *restfulHeader =
      [self commRESTHeadersWithService:service signature:signature];
  NSMutableURLRequest *request =
      [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                          timeoutInterval:kLDNetworkingTimeoutSeconds];
  request.HTTPMethod = @"GET";
  [restfulHeader
      enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
      }];
  request.requestParams = requestParams;
  [LDLogger logDebugInfoWithRequest:request
                            apiName:methodName
                            service:service
                      requestParams:requestParams
                         httpMethod:@"RESTful GET"];
  return request;
}

- (NSURLRequest *)
generateRestfulPOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                  requestParams:(NSDictionary *)requestParams
                                     methodName:(NSString *)methodName {
  LDService *service = [[LDServiceFactory sharedInstance]
      serviceWithIdentifier:serviceIdentifier];
  NSDictionary *commonParams = [LDCommonParamsGenerator commonParamsDictionary];
  NSString *signature =
      [LDSignatureGenerator signRestfulPOSTWithApiParams:requestParams
                                            commonParams:commonParams
                                              methodName:methodName
                                              apiVersion:service.apiVersion
                                              privateKey:service.privateKey];
  NSString *urlString =
      [NSString stringWithFormat:@"%@%@/%@?&%@", service.apiBaseUrl,
                                 service.apiVersion, methodName,
                                 [commonParams LD_urlParamsStringSignature:NO]];

  NSDictionary *restfulHeader =
      [self commRESTHeadersWithService:service signature:signature];
  NSMutableURLRequest *request =
      [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                          timeoutInterval:kLDNetworkingTimeoutSeconds];
  request.HTTPMethod = @"POST";
  [restfulHeader
      enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
      }];
  request.HTTPBody =
      [NSJSONSerialization dataWithJSONObject:requestParams
                                      options:NSJSONWritingPrettyPrinted
                                        error:NULL];
  request.requestParams = requestParams;
  [LDLogger logDebugInfoWithRequest:request
                            apiName:methodName
                            service:service
                      requestParams:requestParams
                         httpMethod:@"RESTful POST"];
  return request;
}

#pragma mark - private methods
- (NSDictionary *)commRESTHeadersWithService:(LDService *)service
                                   signature:(NSString *)signature {
  NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
  [headerDic setValue:signature forKey:@"sig"];
  [headerDic setValue:service.publicKey forKey:@"key"];
  [headerDic setValue:@"application/json" forKey:@"Accept"];
  [headerDic setValue:@"application/json" forKey:@"Content-Type"];
  NSDictionary *loginResult =
      [[NSUserDefaults standardUserDefaults] objectForKey:@"______"];
  if (loginResult[@"auth_token"]) {
    [headerDic setValue:loginResult[@"auth_token"] forKey:@"AuthToken"];
  }
  return headerDic;
}

@end
