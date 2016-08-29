//
//  VideosDetailAPIManager.m
//  jjb_user
//
//  Created by Check on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "VideosDetailAPIManager.h"

@interface VideosDetailAPIManager ()

@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;

@end

@implementation VideosDetailAPIManager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"Videos/selectVideosDetail";
        _serviceType = kLDServiceJJBUser;
        _requestType = LDAPIManagerRequestTypePost;
        self.validator = self;
        self.interceptor = self;
    }
    return self;
}

#pragma mark - LDAPIManagerValidator
- (BOOL)manager:(LDAPIBaseManager *)manager
isCorrectWithCallBackData:(NSDictionary *)data {
    
    if (![data[@"code"] isEqualToString:@"200"]) {
        return NO;
    }
    return YES;
}

- (BOOL)manager:(LDAPIBaseManager *)manager
isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t VideosDetailAPIManagerOnceToken;
    static VideosDetailAPIManager *sharedInstance = nil;
    dispatch_once(&VideosDetailAPIManagerOnceToken, ^{
        sharedInstance = [[VideosDetailAPIManager alloc] init];
    });
    return sharedInstance;
}

@end