//
//  CTMediator+CTMediatorSystemActions.m
//  jjb_user
//
//  Created by Aimee on 16/8/6.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator+CTMediatorSystemActions.h"

NSString * const kCTMediatorSystemTarget = @"System";
NSString * const kCTMediatorActionNativeLogin = @"Login";
@implementation CTMediator (CTMediatorSystemActions)

- (UIViewController *)CTMediator_CheckIsLogin:(UIViewController*)targetController{
    if ([UserModel isHasLogin]) {
        return targetController;
    } else{
        
        return [self performTarget:kCTMediatorSystemTarget
                 action:kCTMediatorActionNativeLogin
                 params:nil];
    }
}

- (UIViewController *)CTMediator_CheckIsLogin{
    if ([UserModel isHasLogin]) {
        return nil;
    } else{
        return [self performTarget:kCTMediatorSystemTarget
                            action:kCTMediatorActionNativeLogin
                            params:nil];
    }
}



@end
