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
        NSTimeInterval time = [dataDict[@"orderTime"] doubleValue]/1000;
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
        NSString * timeString = [date formattedDateWithFormat:@"YYYY-MM-dd hh:mm:ss"];
        
        return @{
                 
                 kOrdersDetailID:[dataDict[@"id"] stringValue],
                 kOrdersDetailCourseNum:dataDict[@"courseNum"],
                 kOrdersDetailName:dataDict[@"name"],
                 kOrdersDetailImage:dataDict[@"image"],
                 kOrdersDetailOrderTime:timeString,
                 kOrdersDetailOrderUser:dataDict[@"orderUser"],
                 kOrdersDetailOrderNO:dataDict[@"orderNo"],
                 kOrdersDetailPayPrice:[dataDict[@"payPrice"] stringValue],
                 kOrdersDetailShopName:dataDict[@"shopName"],
                 kOrdersDetailZKPrice:[dataDict[@"zkPrice"] stringValue],
                 kOrdersDetailPrice:[dataDict[@"price"] stringValue]
                 };
    }
    return nil;
}


@end
