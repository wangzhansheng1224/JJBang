//
//  AXApiSignatureVerifier.m
//  RTNetworking
//
//  Created by casa on 14-5-13.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "LDSignatureGenerator.h"
#import "LDCommonParamsGenerator.h"
#import "NSDictionary+LDNetworkingMethods.h"
#import "NSString+LDNetworkingMethods.h"
#import "NSArray+LDNetworkingMethods.h"

@implementation LDSignatureGenerator

#pragma mark - public methods
+ (NSString *)signGetWithSigParams:(NSDictionary *)allParams
                        methodName:(NSString *)methodName
                        apiVersion:(NSString *)apiVersion
                        privateKey:(NSString *)privateKey
                         publicKey:(NSString *)publicKey {
  return @"signature";
}

+ (NSString *)signRestfulGetWithAllParams:(NSDictionary *)allParams
                               methodName:(NSString *)methodName
                               apiVersion:(NSString *)apiVersion
                               privateKey:(NSString *)privateKey {
  return @"signature";
}

+ (NSString *)signPostWithApiParams:(NSDictionary *)apiParams
                         privateKey:(NSString *)privateKey
                          publicKey:(NSString *)publicKey {
  return @"signature";
}

+ (NSString *)signRestfulPOSTWithApiParams:(id)apiParams
                              commonParams:(NSDictionary *)commonParams
                                methodName:(NSString *)methodName
                                apiVersion:(NSString *)apiVersion
                                privateKey:(NSString *)privateKey {
  return @"signature";
}

@end
