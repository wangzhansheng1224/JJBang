//
//  CTMediator+CTMediatorCourseActions.h
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (CTMediatorCourseActions)
- (UIViewController *)CTMediator_CourseDetail:(NSDictionary *)params;
- (UIViewController *)CTMediator_CourseList:(NSDictionary *)params;
@end