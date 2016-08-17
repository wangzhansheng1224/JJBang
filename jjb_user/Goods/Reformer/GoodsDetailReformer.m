//
//  GoodsDetailReformer.m
//  jjb_user
//
//  Created by Check on 16/8/17.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "GoodsDetailReformer.h"
#import "GoodsDetailAPIManager.h"

NSString *const kGoodsDetailID=@"GoodsDetailID";
NSString *const kGoodsDetailName=@"GoodsDetailName";
NSString *const kGoodsDetailPrice=@"GoodsDetailPrice";
NSString *const kGoodsDetaildescribe=@"GoodsDetaildescribe";
NSString *const kGoodsDetailCategoryName=@"GoodsDetailCategoryName";
NSString *const kGoodsDetailImages=@"GoodsDetailImages";

@implementation GoodsDetailReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    
    if ([manager isKindOfClass:[GoodsDetailAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            
//            NSURL *url;
//            if (arrData[i][@"image"]!=[NSNull null]) {
//                url=   [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",ImageServer,arrData[i][@"image"]]];
//            }
            
            NSDictionary *itemData=@{
                                     kGoodsDetailID:arrData[i][@"id"],
                                     kGoodsDetailName:arrData[i][@"name"],
                                     kGoodsDetailPrice:arrData[i][@"price"],
                                     kGoodsDetaildescribe:arrData[i][@"describe"],
                                     kGoodsDetailCategoryName:arrData[i][@"categoryName"],
                                     kGoodsDetailImages:arrData[i][@"images"]
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}
@end