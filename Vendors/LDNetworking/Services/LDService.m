//
//  Service.m
//  Common
//
//  Created by Owen on 15/8/21.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDService.h"

@implementation LDService

- (instancetype)init {
  self = [super init];
  if (self) {
    if ([self conformsToProtocol:@protocol(LDServiceProtocal)]) {
      self.child = (id<LDServiceProtocal>)self;
    }
  }
  return self;
}

#pragma mark - getters and setters
- (NSString *)privateKey {
  return self.child.isOnline ? self.child.onlinePrivateKey
                             : self.child.offlinePrivateKey;
}

- (NSString *)publicKey {
  return self.child.isOnline ? self.child.onlinePublicKey
                             : self.child.offlinePublicKey;
}

- (NSString *)apiBaseUrl {
  return self.child.isOnline ? self.child.onlineApiBaseUrl
                             : self.child.offlineApiBaseUrl;
}

- (NSString *)apiVersion {
  return self.child.isOnline ? self.child.onlineApiVersion
                             : self.child.offlineApiVersion;
}

@end
