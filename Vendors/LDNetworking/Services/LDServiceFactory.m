//
//  ServiceFactory.m
//  Common
//
//  Created by Owen on 15/8/21.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDServiceFactory.h"
#import "LDService.h"

#import "LDserviceJJBUser.h"

NSString *const kLDServiceJJBUser = @"kLDServiceJJBUser";

@interface LDServiceFactory ()
@property(nonatomic, strong) NSMutableDictionary *serviceStorage;
@end

@implementation LDServiceFactory
#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage {
  if (_serviceStorage == nil) {
    _serviceStorage = [[NSMutableDictionary alloc] init];
  }
  return _serviceStorage;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance {
  static dispatch_once_t onceToken;
  static LDServiceFactory *sharedInstance;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[LDServiceFactory alloc] init];
  });
  return sharedInstance;
}

#pragma mark - public methods
- (LDService<LDServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier {
  if (self.serviceStorage[identifier] == nil) {
    self.serviceStorage[identifier] =
        [self newServiceWithIdentifier:identifier];
  }
  return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (LDService<LDServiceProtocal> *)newServiceWithIdentifier:
    (NSString *)identifier {

  if ([identifier isEqualToString:kLDServiceJJBUser]) {
    return [[LDServiceJJBUser alloc] init];
  }
  return nil;
}
@end
