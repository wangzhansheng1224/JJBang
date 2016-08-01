//
//  NSURLRequest+AIFNetworkingMethods.m
//  RTNetworking
//
//  Created by casa on 14-5-26.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "NSURLRequest+LDNetworkingMethods.h"
#import <objc/runtime.h>

static void *LDNetworkingRequestParams;

@implementation NSURLRequest (LDNetworkingMethods)

- (void)setRequestParams:(NSDictionary *)requestParams {
  objc_setAssociatedObject(self, &LDNetworkingRequestParams, requestParams,
                           OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams {
  return objc_getAssociatedObject(self, &LDNetworkingRequestParams);
}

@end
