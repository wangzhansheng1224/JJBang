//
//  LDServiceJJBUser.m
//  jjb_user
//
//  Created by Aimee on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LDServiceJJBUser.h"

@implementation LDServiceJJBUser
#pragma mark - LDServiceProtocal
- (BOOL)isOnline {
    return YES;
}

- (NSString *)onlineApiBaseUrl {
    return @"http://123.56.225.133/";
}

- (NSString *)onlineApiVersion {
    return @"v1";
}

- (NSString *)onlinePrivateKey {
    return @"";
}

- (NSString *)onlinePublicKey {
    return @"";
}

- (NSString *)offlineApiBaseUrl {
    return self.onlineApiBaseUrl;
}

- (NSString *)offlineApiVersion {
    return self.onlineApiVersion;
}

- (NSString *)offlinePrivateKey {
    return self.onlinePrivateKey;
}

- (NSString *)offlinePublicKey {
    return self.onlinePublicKey;
}
@end
