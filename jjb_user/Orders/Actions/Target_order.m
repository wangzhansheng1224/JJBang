//
//  Target_order.m
//  jjb_user
//
//  Created by Aimee on 16/8/30.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "Target_order.h"
#import "OrdersDetailController.h"

@implementation Target_order
- (id)Action_pay:(NSDictionary *)params{
    OrdersDetailController *detail=[[OrdersDetailController alloc] init];
    detail.orderNo=params[@"order_id"];
    return detail;
}
@end
