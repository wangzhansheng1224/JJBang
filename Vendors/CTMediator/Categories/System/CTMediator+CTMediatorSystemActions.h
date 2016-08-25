//
//  CTMediator+CTMediatorSystemActions.h
//  jjb_user
//
//  Created by Aimee on 16/8/6.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (CTMediatorSystemActions)
- (UIViewController *)CTMediator_CheckIsLogin:(UIViewController*)targetController;
- (UIViewController *)CTMediator_CheckIsLogin;
@end
