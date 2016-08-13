//
//  CTMediator+CTMediatorActivityActions.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator+CTMediatorActivityActions.h"

NSString * const kCTMediatorActivityTarget = @"Activity";
NSString * const kCTMediatorActionNativeActivityDetail = @"ActivityDetail";

@implementation CTMediator (CTMediatorActivityActions)
- (UIViewController *)CTMediator_ActivityDetail:(NSDictionary *)params{
    
    return [self performTarget:kCTMediatorActivityTarget
                        action:kCTMediatorActionNativeActivityDetail
                        params:params];
}
@end
