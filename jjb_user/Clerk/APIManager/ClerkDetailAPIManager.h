//
//  ClerkDetailAPIManager.h
//  jjb_user
//
//  Created by Maybe on 16/8/29.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface ClerkDetailAPIManager : LDAPIBaseManager<LDAPIManager, LDAPIManagerValidator,
LDAPIManagerInterceptor>
+ (instancetype)sharedInstance;


@end
