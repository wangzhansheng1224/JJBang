//
//  OrderStatusAPImanager.h
//  jjb_user
//
//  Created by Aimee on 16/8/23.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface OrderStatusAPImanager : LDAPIBaseManager<LDAPIManager, LDAPIManagerValidator,
LDAPIManagerInterceptor>
@property(nonatomic, copy, readwrite) NSString *methodName;

+ (instancetype)sharedInstance;


@end
