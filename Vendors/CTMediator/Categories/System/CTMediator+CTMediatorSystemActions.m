//
//  CTMediator+CTMediatorSystemActions.m
//  jjb_user
//
//  Created by Aimee on 16/8/6.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator+CTMediatorSystemActions.h"

NSString * const kCTMediatorTarget = @"System";
NSString * const kCTMediatorActionNativeLogin = @"Login";
@implementation CTMediator (CTMediatorSystemActions)

- (UIViewController *)CTMediator_CheckIsLogin:(UIViewController*)targetController{
    if ([UserModel isHasLogin]) {
        return targetController;
    } else{
        
        return [self performTarget:kCTMediatorTarget
                 action:kCTMediatorActionNativeLogin
                 params:nil];
    }
}

@end
