//
//  MyOrderDetailReformer.m
//  jjb_user
//
//  Created by Maybe on 16/8/22.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyOrderDetailReformer.h"
#import "MyOrderDetailKey.h"
#import "MyOrderDetailAPIManager.h"
@implementation MyOrderDetailReformer


NSString * const kMyOrderDetailName = @"kMyOrderDetailName";
NSString * const kMyOrderDetailPrice = @"kMyOrderDetailPrice";
NSString * const kMyOrderDetailTime = @"kMyOrderDetailTime";
NSString * const kMyOrderDetailID = @"kMyOrderDetailID";
-(id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[MyOrderDetailAPIManager class]]) {
        NSMutableArray * arrResult = [NSMutableArray array];
        NSArray * arrData = data[@"data"];
        
        for (NSInteger i = 0 ; i< arrData.count; i++) {
            
            NSDate * date = [NSDate dateWithTimeIntervalSince1970:[arrData[i][@"time"]doubleValue]/1000];
            NSString * time = [date formattedDateWithFormat:@"YYYY-MM-dd hh:mm:ss"];
            
            NSString * priceString = [NSString stringWithFormat:@"%f",[arrData[i][@"price"]doubleValue]];
            
            
            NSDictionary * itemData = @{
                                        kMyOrderDetailID:arrData[i][@"id"],
                                        kMyOrderDetailName:arrData[i][@"name"],
                                        kMyOrderDetailPrice:priceString,
                                        kMyOrderDetailTime:time
                                        
                                        
                                        };
            [arrResult addObject:itemData];
        }
        return arrResult;
//        NSDictionary * dict = data[@"data"];
//        NSDictionary * tempDict = @{
//                                    kMyOrderDetailName:dict[@"id"],
//                                    kMyOrderDetailPrice:dict[@"name"],
//                                    kMyOrderDetailTime:dict[@"price"],
//                                    kMyOrderDetailID:dict[@"time"]
//                                    
//                                    
//                                    };
//        return tempDict;

    }
    return nil;
    }

@end
