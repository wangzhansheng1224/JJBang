//
//  AXLogger.h
//  RTNetworking
//
//  Created by casa on 14-5-6.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDService.h"
#import "LDLoggerConfiguration.h"
#import "LDURLResponse.h"

@interface LDLogger : NSObject

@property(nonatomic, strong, readonly) LDLoggerConfiguration *configParams;

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                        apiName:(NSString *)apiName
                        service:(LDService *)service
                  requestParams:(id)requestParams
                     httpMethod:(NSString *)httpMethod;
+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                   resposeString:(NSString *)responseString
                         request:(NSURLRequest *)request
                           error:(NSError *)error;
+ (void)logDebugInfoWithCachedResponse:(LDURLResponse *)response
                            methodName:(NSString *)methodName
                     serviceIdentifier:(LDService *)service;

+ (instancetype)sharedInstance;
- (void)logWithActionCode:(NSString *)actionCode params:(NSDictionary *)params;

@end
