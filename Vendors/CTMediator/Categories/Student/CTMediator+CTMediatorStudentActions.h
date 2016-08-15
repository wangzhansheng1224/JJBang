//
//  CTMediator+CTMediatorStudentActions.h
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (CTMediatorStudentActions)
- (UIViewController *)CTMediator_StudentDetail:(NSDictionary *)params;
- (UIViewController *)CTMediator_StudentList:(NSDictionary *)params;
@end
