//
//  APIProxy.h
//  Common
//
//  Created by Owen on 15/8/21.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDURLResponse.h"

typedef void (^LDCallback)(LDURLResponse *response);
@interface LDApiProxy : NSObject
+ (instancetype)sharedInstance;

- (NSInteger)callGETWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(LDCallback)success
                          fail:(LDCallback)fail;
- (NSInteger)callPOSTWithParams:(NSDictionary *)params
              serviceIdentifier:(NSString *)servieIdentifier
                     methodName:(NSString *)methodName
                        success:(LDCallback)success
                           fail:(LDCallback)fail;

- (NSInteger)callRestfulGETWithParams:(NSDictionary *)params
                    serviceIdentifier:(NSString *)servieIdentifier
                           methodName:(NSString *)methodName
                              success:(LDCallback)success
                                 fail:(LDCallback)fail;
- (NSInteger)callRestfulPOSTWithParams:(NSDictionary *)params
                     serviceIdentifier:(NSString *)servieIdentifier
                            methodName:(NSString *)methodName
                               success:(LDCallback)success
                                  fail:(LDCallback)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end
