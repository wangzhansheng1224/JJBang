//
//  CTMediator+CTMediatorTeacherActions.h
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (CTMediatorTeacherActions)
- (UIViewController *)CTMediator_TeacherDetail:(NSDictionary *)params;
- (UIViewController *)CTMediator_TeacherList:(NSDictionary *)params;
@end
