//
//  GoodsListReformer.m
//  jjb_user
//
//  Created by Check on 16/8/15.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GoodsListReformer.h"
#import "GoodsListAPIManager.h"

NSString *const kGoodsListID = @"GoodsListID";
NSString *const kGoodsListImageUrl = @"GoodsListImageUrl";
NSString *const kGoodsListToName = @"GoodsListToName";
NSString *const kGoodsListToPrice = @"GoodsListToPrice";

@implementation GoodsListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    
    if ([manager isKindOfClass:[GoodsListAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
//        NSArray *imgArr=data[@"images"];
        for (NSInteger i=0; i< [arrData count]; i++) {
           
            NSString *imgPath;
            NSArray *imgArr=arrData[i][@"images"];
            
            if (imgArr!=nil&&[imgArr count]>0) {
                imgPath=imgArr[0][@"image"];
            }
            
            NSDictionary *itemData=@{
                                     kGoodsListID:arrData[i][@"id"],
                                     kGoodsListToName:arrData[i][@"name"],
                                     kGoodsListToPrice:arrData[i][@"price"],
                                     kGoodsListImageUrl:imgPath
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}
@end
