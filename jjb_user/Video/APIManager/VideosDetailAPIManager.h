//
//  VideosDetailAPIManager.h
//  jjb_user
//
//  Created by Check on 16/8/28.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface VideosDetailAPIManager : LDAPIBaseManager<LDAPIManager, LDAPIManagerValidator,
LDAPIManagerInterceptor>
+ (instancetype)sharedInstance;

@end