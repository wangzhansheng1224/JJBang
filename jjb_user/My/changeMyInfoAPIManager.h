//
//  changeMyInfoAPIManager.h
//  jjb_user
//
//  Created by Maybe on 16/9/1.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface changeMyInfoAPIManager : LDAPIBaseManager<LDAPIManager, LDAPIManagerValidator,
LDAPIManagerInterceptor>
+ (instancetype)sharedInstance;
//@property(nonatomic, copy, readwrite) NSString *methodName;


@end
