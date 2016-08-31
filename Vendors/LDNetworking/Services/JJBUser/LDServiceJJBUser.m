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
    return @"http://115.29.221.199:8081/sys/rest/";
//    return  @"http://139.129.110.116:8080/sys/rest/"; //正式
}

- (NSString *)onlineApiVersion {
    return @"";
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
