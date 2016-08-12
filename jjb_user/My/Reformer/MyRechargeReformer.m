//
//  MyRechargeReformer.m
//  jjb_user
//
//  Created by Maybe on 16/8/12.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "MyRechargeReformer.h"
#import "MyRechargeAPIManager.h"

 NSString * const kMyRechargePrepayId = @"kMyRechargePrepayId";
 NSString * const kMyRechargeOrder = @"kMyRechargeOrder";
 NSString * const kMyRechargeTimeStamp = @"kMyRechargeTimeStamp";
@implementation MyRechargeReformer

-(id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[MyRechargeAPIManager class]]) {
        NSMutableArray * arrResult = [NSMutableArray array];
        NSArray * arrData = data[@"data"];
   
    for (NSInteger i = 0 ; i< arrData.count; i++) {
        NSDictionary * itemData = @{kMyRechargePrepayId:arrData[i][@"prepayid"],
                                    kMyRechargeOrder:arrData[i][@"order"],
                                    kMyRechargeTimeStamp:arrData[i][@"timestamp"]
                                
                                    };
        [arrResult addObject:itemData];
    }
        return arrResult;
         }
    return nil;
}
@end
