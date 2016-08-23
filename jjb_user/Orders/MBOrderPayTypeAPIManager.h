//
//  MBOrderPayTypeAPIManager.h
//  jjb_user
//
//  Created by Maybe on 16/8/22.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface MBOrderPayTypeAPIManager : LDAPIBaseManager<LDAPIManager, LDAPIManagerValidator,
LDAPIManagerInterceptor>
@property(nonatomic, copy, readwrite) NSString *methodName;

+ (instancetype)sharedInstance;

@end
