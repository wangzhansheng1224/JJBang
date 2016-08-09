//
//  ShopClassifyModel.m
//  jjb_user
//
//  Created by Maybe on 16/8/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopClassifyModel.h"

@implementation ShopClassifyModel

+(instancetype)classifyWithDict:(NSDictionary *)dict
{
    ShopClassifyModel * classModel = [[self alloc]init];
    [classModel setValuesForKeysWithDictionary:dict];
    return classModel;
}
@end
