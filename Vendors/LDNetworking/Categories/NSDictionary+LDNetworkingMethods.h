//
//  NSDictionary+AXNetworkingMethods.h
//  RTNetworking
//
//  Created by casa on 14-5-6.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LDNetworkingMethods)

- (NSString *)LD_urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)LD_jsonString;
- (NSArray *)LD_transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end
