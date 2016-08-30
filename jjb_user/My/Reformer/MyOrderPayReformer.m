//
//  MyOrderPayReformer.m
//  jjb_user
//
//  Created by Check on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyOrderPayReformer.h"
#import "MyOrderPayKey.h"
#import "MyOrderAPIManager.h"

@implementation MyOrderPayReformer

NSString * const kMyOrderPayId=@"MyOrderPayId";
NSString * const kMyOrderPayOrderNo=@"MyOrderPayOrderNo";
NSString * const kMyOrderPayOrderStatus=@"MyOrderPayOrderStatus";
NSString * const kMyOrderPayOrderName=@"MyOrderPayOrderName";
NSString * const kMyOrderPayOrderImage=@"MyOrderPayOrderImage";
NSString * const kMyOrderPayOrderPrice=@"MyOrderPayOrderPrice";
NSString * const kMyOrderPayOrderOrderType=@"MyOrderPayOrderOrderType";
NSString * const kMyOrderPayOrderCTime=@"MyOrderPayOrderCTime";

-(id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[MyOrderAPIManager class]]) {
        NSMutableArray * arrResult = [NSMutableArray array];
        NSArray * arrData = data[@"data"];
        
        for (NSInteger i = 0 ; i< arrData.count; i++) {
            NSDate * date = [NSDate dateWithTimeIntervalSince1970:[arrData[i][@"ctime"]doubleValue]/1000];
            NSString * time = [date formattedDateWithFormat:@"YYYY-MM-dd hh:mm:ss"];
            
            NSString * priceString = [NSString stringWithFormat:@"%.2f",[arrData[i][@"price"]doubleValue]];
            
            
            NSDictionary * itemData = @{
                                        kMyOrderPayId:arrData[i][@"id"],
                                        kMyOrderPayOrderNo:arrData[i][@"orderNo"],
                                        kMyOrderPayOrderStatus:arrData[i][@"status"],
                                        kMyOrderPayOrderName:arrData[i][@"name"],
                                        kMyOrderPayOrderImage:arrData[i][@"image"],
                                        kMyOrderPayOrderPrice:priceString,
                                        kMyOrderPayOrderOrderType:arrData[i][@"order_type"],
                                        kMyOrderPayOrderCTime:time
                                        };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}

@end
