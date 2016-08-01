//
//  LDURLResponse.m
//  Common
//
//  Created by Owen on 15/8/21.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDURLResponse.h"
#import "NSObject+LDNetworkingMethods.h"
#import "NSURLRequest+LDNetworkingMethods.h"
@interface LDURLResponse ()

@property(nonatomic, assign, readwrite) LDURLResponseStatus status;
@property(nonatomic, copy, readwrite) NSString *contentString;
@property(nonatomic, copy, readwrite) id content;
@property(nonatomic, copy, readwrite) NSURLRequest *request;
@property(nonatomic, assign, readwrite) NSInteger requestId;
@property(nonatomic, copy, readwrite) NSData *responseData;
@property(nonatomic, assign, readwrite) BOOL isCache;

@end
@implementation LDURLResponse
#pragma mark - life cycle
- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(LDURLResponseStatus)status {
  self = [super init];
  if (self) {
    self.contentString = responseString;
    self.content =
        [NSJSONSerialization JSONObjectWithData:responseData
                                        options:NSJSONReadingMutableContainers
                                          error:NULL];
    self.status = status;
    self.requestId = [requestId integerValue];
    self.request = request;
    self.responseData = responseData;
    self.requestParams = request.requestParams;
    self.isCache = NO;
  }
  return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error {
  self = [super init];
  if (self) {
    self.contentString = [responseString LD_defaultValue:@""];
    self.status = [self responseStatusWithError:error];
    self.requestId = [requestId integerValue];
    self.request = request;
    self.responseData = responseData;
    self.requestParams = request.requestParams;
    self.isCache = NO;

    if (responseData) {
      self.content =
          [NSJSONSerialization JSONObjectWithData:responseData
                                          options:NSJSONReadingMutableContainers
                                            error:NULL];
    } else {
      self.content = nil;
    }
  }
  return self;
}

- (instancetype)initWithData:(NSData *)data {
  self = [super init];
  if (self) {
    self.contentString =
        [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.status = [self responseStatusWithError:nil];
    self.requestId = 0;
    self.request = nil;
    self.responseData = [data copy];
    self.content =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingMutableContainers
                                          error:NULL];
    self.isCache = YES;
  }
  return self;
}

#pragma mark - private methods
- (LDURLResponseStatus)responseStatusWithError:(NSError *)error {
  if (error) {
    LDURLResponseStatus result = LDURLResponseStatusErrorNoNetwork;

    // 除了超时以外，所有错误都当成是无网络
    if (error.code == NSURLErrorTimedOut) {
      result = LDURLResponseStatusErrorNoNetwork;
    }
    if (error.code == kCFURLErrorBadURL) {
      result = LDURLResponseStatusErrorNotFound;
    }
    if (error.code == kCFURLErrorBadServerResponse) {
      result = LDURLResponseStatusErrorUnauthorized;
    }
    return result;
  } else {
    return LDURLResponseStatusSuccess;
  }
}

@end
