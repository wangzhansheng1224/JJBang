//
//  Target_System.m
//  jjb_user
//
//  Created by Aimee on 16/8/6.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "Target_System.h"
#import "LoginViewController.h"

@implementation Target_System

- (id)Action_Login:(NSDictionary *)params
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    return loginVC;
}

@end
