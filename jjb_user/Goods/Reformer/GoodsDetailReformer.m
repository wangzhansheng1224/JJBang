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
        NSDictionary *dataDic=data[@"data"];
        return  @{
                                     kGoodsDetailID:dataDic[@"id"],
                                     kGoodsDetailName:dataDic[@"name"],
                                     kGoodsDetailPrice:dataDic[@"price"],
                                     kGoodsDetaildescribe:dataDic[@"describe"],
                                     kGoodsDetailCategoryName:dataDic[@"categoryName"],
                                     kGoodsDetailImages:dataDic[@"images"]
                                     };

    }
    return nil;
}
@end