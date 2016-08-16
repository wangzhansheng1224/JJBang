//
//  CTMediator+CTMediatorGoodsActions.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CTMediator+CTMediatorGoodsActions.h"
NSString * const kCTMediatorGoodsTarget = @"Goods";
NSString * const kCTMediatorActionNativeGoodsDetail = @"GoodsDetail";
NSString * const kCTMediatorActionNativeGoodsList = @"GoodsList";
@implementation CTMediator (CTMediatorGoodsActions)
- (UIViewController *)CTMediator_GoodsDetail:(NSDictionary *)params{
    
    return [self performTarget:kCTMediatorGoodsTarget
                        action:kCTMediatorActionNativeGoodsDetail
                        params:params];
}

- (UIViewController *)CTMediator_GoodsList:(NSDictionary *)params{
    
    return [self performTarget:kCTMediatorGoodsTarget
                        action:kCTMediatorActionNativeGoodsList
                        params:params];
}
@end
