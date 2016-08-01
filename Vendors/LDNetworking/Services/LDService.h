//
//  Service.h
//  Common
//
//  Created by Owen on 15/8/21.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

// 所有LDService的派生类都要符合这个protocal
@protocol LDServiceProtocal <NSObject>

@property(nonatomic, readonly) BOOL isOnline;

@property(nonatomic, readonly) NSString *offlineApiBaseUrl;
@property(nonatomic, readonly) NSString *onlineApiBaseUrl;

@property(nonatomic, readonly) NSString *offlineApiVersion;
@property(nonatomic, readonly) NSString *onlineApiVersion;

@property(nonatomic, readonly) NSString *onlinePublicKey;
@property(nonatomic, readonly) NSString *offlinePublicKey;

@property(nonatomic, readonly) NSString *onlinePrivateKey;
@property(nonatomic, readonly) NSString *offlinePrivateKey;

@end

@interface LDService : NSObject
@property(nonatomic, strong, readonly) NSString *publicKey;
@property(nonatomic, strong, readonly) NSString *privateKey;
@property(nonatomic, strong, readonly) NSString *apiBaseUrl;
@property(nonatomic, strong, readonly) NSString *apiVersion;

@property(nonatomic, weak) id<LDServiceProtocal> child;
@end
