//
//  Target_My.m
//  jjb_user
//
//  Created by Aimee on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "Target_My.h"
#import "MyOrderDetailController.h"

@implementation Target_My
- (id)Action_OrderDetail:(NSDictionary *)params{
    MyOrderDetailController *orderDetail = [[MyOrderDetailController alloc] init];
    return orderDetail;
}
@end
