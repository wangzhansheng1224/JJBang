//
//  ShopIndexAPIManager.h
//  jjb_user
//
//  Created by Aimee on 16/8/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//


@interface ActivityDetailAPIManager : LDAPIBaseManager<LDAPIManager, LDAPIManagerValidator,
LDAPIManagerInterceptor>
+ (instancetype)sharedInstance;
@end
