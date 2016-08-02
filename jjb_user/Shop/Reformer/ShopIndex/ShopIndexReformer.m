//
//  ShopIndexReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopIndexReformer.h"

@implementation ShopIndexReformer

NSString *const kShopIndexShopList=@"ShopList";
NSString *const kShopIndexActImg=@"ActImg";
NSString *const kShopIndexGoodsList=@"GoodsList";
NSString *const kShopIndexSdtList=@"SdtList";
NSString *const kShopIndexTechList=@"TechList";
NSString *const kShopIndexRadioList=@"RadioList";
NSString *const kShopIndexCourseList=@"CourseList";


- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    return @{
             @"ShopList" : data[kShopIndexShopList] != [NSNull null]
             ? data[kShopIndexShopList]
             : @"",
             @"ActImg" : data[kShopIndexActImg] != [NSNull null]
             ? data[kShopIndexActImg]
             : @"",
             @"GoodsList" : data[kShopIndexGoodsList] != [NSNull null]
             ? data[kShopIndexGoodsList]
             : @"",
             @"SdtList" : data[kShopIndexSdtList] != [NSNull null]
             ? data[kShopIndexSdtList]
             : @"",
             @"TechList" : data[kShopIndexTechList] != [NSNull null]
             ? data[kShopIndexTechList]
             : @"",
             @"RadioList" : data[kShopIndexRadioList] != [NSNull null]
             ? data[kShopIndexRadioList]
             : @"",
             @"CourseList" : data[kShopIndexCourseList] != [NSNull null]
             ? data[kShopIndexCourseList]
             : @""
             };
}
@end
