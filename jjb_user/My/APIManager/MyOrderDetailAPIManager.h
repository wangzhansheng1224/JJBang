//
//  MyOrderDetailAPIManager.h
//  jjb_user
//
//  Created by Maybe on 16/8/22.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface MyOrderDetailAPIManager : LDAPIBaseManager<LDAPIManager, LDAPIManagerValidator,
LDAPIManagerInterceptor>
+ (instancetype)sharedInstance;
@property(nonatomic, copy, readwrite) NSString *methodName;

@end
