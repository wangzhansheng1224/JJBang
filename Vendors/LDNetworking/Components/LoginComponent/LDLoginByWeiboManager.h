//
//  LDLoginByWeiboManager.h
//  Common
//
//  Created by Owen on 15/8/26.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface LDLoginByWeiboManager
    : LDAPIBaseManager <LDAPIManager, LDAPIManagerValidator,
                        LDAPIManagerInterceptor>
+ (instancetype)sharedInstance;
@end
