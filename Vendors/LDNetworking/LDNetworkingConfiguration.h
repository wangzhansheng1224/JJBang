//
//  NetworkingConfiguration.h
//  Common
//
//  Created by Owen on 15/8/20.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#ifndef Common_LDNetworkingConfiguration_h
#define Common_LDNetworkingConfiguration_h

typedef NS_ENUM(NSUInteger, LDURLResponseStatus) {
  LDURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的RTApiBaseManager来决定。
  LDURLResponseStatusErrorTimeout,
  LDURLResponseStatusErrorUnauthorized, //验证失败
  LDURLResponseStatusErrorNotFound,     //请求不存在
  LDURLResponseStatusErrorNoNetwork
};

static NSTimeInterval kLDNetworkingTimeoutSeconds = 20.0f;

static BOOL kLDShouldCache = YES;
static NSTimeInterval kLDCacheOutdateTimeSeconds = 0; // 5分钟的cache过期时间
static NSUInteger kLDCacheCountLimit = 1000;            // 最多1000条cache

//用户端
extern NSString *const kLDServiceJJBUser;

#endif
