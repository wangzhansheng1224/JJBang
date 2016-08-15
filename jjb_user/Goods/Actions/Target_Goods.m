//
//  Target_Goods.m
//  jjb_user
//
//  Created by Aimee on 16/8/13.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "Target_Goods.h"
#import "GoodsListController.h"
#import "GoodsDetailController.h"

@implementation Target_Goods
- (id)Action_GoodsList:(NSDictionary *)params{
    GoodsListController *list = [[GoodsListController alloc] init];
    return list;
}

- (id)Action_GoodsDetail:(NSDictionary *)params{
    GoodsDetailController *detail = [[GoodsDetailController alloc] init];
    detail.goodsID=[params[@"goodsID"] integerValue];
    return detail;
}
@end
