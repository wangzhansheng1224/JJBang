//
//  CTMediator+CTMediatorMyActions.m
//  jjb_user
//
//  Created by Aimee on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator+CTMediatorMyActions.h"
NSString * const kCTMediatorMyTarget = @"My";
NSString * const kCTMediatorActionNativeOrderDetail = @"OrderDetail";
@implementation CTMediator (CTMediatorMyActions)

- (UIViewController *)CTMediator_OrderDetail:(NSDictionary *)params{
    
    return [self performTarget:kCTMediatorMyTarget
                        action:kCTMediatorActionNativeOrderDetail
                        params:params];
}

@end
