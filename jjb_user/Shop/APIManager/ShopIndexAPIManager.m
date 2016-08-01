//
//  ShopIndexAPIManager.m
//  jjb_user
//
//  Created by Aimee on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopIndexAPIManager.h"

@implementation ShopIndexAPIManager
+ (instancetype)sharedInstance {
    static dispatch_once_t ShopIndexAPIManagerOnceToken;
    static ShopIndexAPIManager *sharedInstance = nil;
    dispatch_once(&ShopIndexAPIManagerOnceToken, ^{
        sharedInstance = [[ShopIndexAPIManager alloc] init];
    });
    return sharedInstance;
}
@end
