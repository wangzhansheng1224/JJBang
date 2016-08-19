//
//  OrderDetailReformer.m
//  jjb_user
//
//  Created by Maybe on 16/8/19.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "OrderDetailReformer.h"
#import "OrderDetailAPIManager.h"
 NSString * const kOrdersDetailID = @"OrderDetailID";
 NSString * const kOrdersDetailCourseNum = @"OrderDetailCourseNum";
 NSString * const kOrdersDetailName = @"OrderDetailName";
 NSString * const kOrdersDetailImage = @"OrderDetailImage";
 NSString * const kOrdersDetailOrderTime = @"OrderDetailOrderTime";
 NSString * const kOrdersDetailOrderUser = @"OrderDetailOrderUser";
 NSString * const kOrdersDetailOrderNO = @"OrderDetailOrderNo";
 NSString * const kOrdersDetailPayPrice = @"OrderDetailPayPrice";
 NSString * const kOrdersDetailPrice = @"OrderDetailPrice";
 NSString * const kOrdersDetailShopName = @"OrderDetailShopName";
 NSString * const kOrdersDetailZKPrice = @"OrderDetailZKPrice";


@implementation OrderDetailReformer

-(id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[OrderDetailAPIManager class]]) {
        NSDictionary * dataDict = data[@"data"];
        return @{
                 
                 kOrdersDetailID:dataDict[@"id"],
                 kOrdersDetailCourseNum:dataDict[@"courseNum"],
                 kOrdersDetailName:dataDict[@"name"],
                 kOrdersDetailImage:dataDict[@"image"],
                 kOrdersDetailOrderTime:dataDict[@"orderTime"],
                 kOrdersDetailOrderUser:dataDict[@"orderUser"],
                 kOrdersDetailOrderNO:dataDict[@"orderNo"],
                 kOrdersDetailPayPrice:dataDict[@"payPrice"],
                 kOrdersDetailShopName:dataDict[@"shopName"],
                 kOrdersDetailZKPrice:dataDict[@"zkPrice"],
                 
                 };
    }
    return nil;
}


@end
