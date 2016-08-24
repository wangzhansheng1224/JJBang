//
//  TeacherDetailAPIManager.h
//  jjb_user
//
//  Created by Aimee on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface TeacherDetailAPIManager : LDAPIBaseManager<LDAPIManager, LDAPIManagerValidator,
LDAPIManagerInterceptor>
+ (instancetype)sharedInstance;
@end
