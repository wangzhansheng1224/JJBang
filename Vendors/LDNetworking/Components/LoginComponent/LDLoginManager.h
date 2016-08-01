//
//  LDLoginManager.h
//  Common
//
//  Created by Owen on 15/8/25.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface LDLoginManager
    : LDAPIBaseManager <LDAPIManager, LDAPIManagerValidator,
                        LDAPIManagerInterceptor>
+ (instancetype)sharedInstance;
@end
