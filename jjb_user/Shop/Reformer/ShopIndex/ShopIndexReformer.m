//
//  ShopIndexReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ShopIndexReformer.h"
#import "ShopIndexAPIManager.h"

@implementation ShopIndexReformer

NSString *const kShopIndexShopList=@"ShopList";
NSString *const kShopIndexActImg=@"ActImg";
NSString *const kShopIndexGoodsList=@"GoodsList";
NSString *const kShopIndexSdtList=@"SdtList";
NSString *const kShopIndexTechList=@"TechList";
NSString *const kShopIndexRadioList=@"RadioList";
NSString *const kShopIndexCourseList=@"CourseList";


NSString *const kShopIndexActImgID=@"ShopIndexActImgID";
NSString *const kShopIndexActImgImagePath=@"ShopIndexActImgImagePath";

NSString *const kShopIndexGoodsListID=@"ShopIndexGoodsListID";
NSString *const kShopIndexGoodsListName=@"ShopIndexGoodsListName";
NSString *const kShopIndexGoodsListImage=@"ShopIndexGoodsListImage";
NSString *const kShopIndexGoodsListPrice=@"ShopIndexGoodsListPrice";


NSString *const kShopIndexTechListID=@"ShopIndexTechListID";
NSString *const kShopIndexTechListPhoto=@"ShopIndexTechListPhoto";
NSString *const kShopIndexTechListName=@"ShopIndexTechListName";
NSString *const kShopIndexTechListStar=@"ShopIndexTechListStar";

NSString *const kShopIndexSdtListID=@"ShopIndexSdtListID";
NSString *const kShopIndexSdtListPhoto=@"ShopIndexSdtListPhoto";
NSString *const kShopIndexSdtListName=@"ShopIndexSdtListName";
NSString *const kShopIndexSdtListNum=@"ShopIndexSdtListNum";


NSString *const kShopIndexCourseListID=@"ShopIndexCourseListID";
NSString *const kShopIndexCourseListImg=@"ShopIndexCourseListImg";
NSString *const kShopIndexCourseListName=@"ShopIndexCourseListName";
NSString *const kShopIndexCourseListPrice=@"ShopIndexCourseListPrice";
NSString *const kShopIndexCourseListNum=@"ShopIndexCourseListNum";
NSString *const kShopIndexCourseListStar=@"ShopIndexCourseListStar";

- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[ShopIndexAPIManager class]]) {
        
        NSDictionary *indexData=data[@"data"];
        NSArray *actImgArray=indexData[@"actImg"];
        NSMutableArray *actImgMArray=[[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i=0; i<[actImgArray count]; i++) {
            [actImgMArray addObject:@{kShopIndexActImgID:actImgArray[i][@"id"],kShopIndexActImgImagePath:actImgArray[i][@"image"]}];
        }
        
        NSArray *goodsList=indexData[@"goodsList"];
        NSMutableArray *goodsMArrary=[[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i=0; i<[goodsList count]; i++) {
            [goodsMArrary addObject:@{
                                      kShopIndexGoodsListID:goodsList[i][@"id"]!= [NSNull null]?goodsList[i][@"id"]:@" ",kShopIndexGoodsListName:goodsList[i][@"name"]!= [NSNull null]?goodsList[i][@"name"]:@" ",
                                      kShopIndexGoodsListImage:goodsList[i][@"image"]!= [NSNull null]?goodsList[i][@"image"]:@" ",
                                      kShopIndexGoodsListPrice:goodsList[i][@"price"]!= [NSNull null]?goodsList[i][@"price"]:@" "
                                      }];
        }
        
        NSArray *techList=indexData[@"techList"];
        NSMutableArray *techMArrary=[[NSMutableArray alloc] initWithCapacity:0];
        
        for (NSInteger i=0; i<[techList count]; i++) {
            [techMArrary addObject:@{
                                     kShopIndexTechListID:techList[i][@"tech_id"]!= [NSNull null]?techList[i][@"tech_id"]:@" ",
                                     kShopIndexTechListPhoto:techList[i][@"tech_photo"]!= [NSNull null]?techList[i][@"tech_photo"]:@" ",
                                     kShopIndexTechListName:techList[i][@"tech_name"]!= [NSNull null]?techList[i][@"tech_name"]:@" ",
                                     kShopIndexTechListStar:techList[i][@"tech_star"]!= [NSNull null]?techList[i][@"tech_star"]:@" "
                                     }];
        }
        
        NSArray *sdtList=indexData[@"sdtList"];
        NSMutableArray *sdtMArrary=[[NSMutableArray alloc] initWithCapacity:0];
        
        for (NSInteger i=0; i<[sdtList count]; i++) {
            [sdtMArrary addObject:@{
                                     kShopIndexSdtListID:sdtList[i][@"sdt_id"]!= [NSNull null]?sdtList[i][@"sdt_id"]:@" ",
                                     kShopIndexSdtListPhoto:sdtList[i][@"sdt_photo"]!= [NSNull null]?sdtList[i][@"sdt_photo"]:@" ",
                                     kShopIndexSdtListName:sdtList[i][@"sdt_name"]!= [NSNull null]?sdtList[i][@"sdt_name"]:@" ",
                                     kShopIndexSdtListNum:sdtList[i][@"num"]!= [NSNull null]?sdtList[i][@"num"]:@" "
                                     }];
        }
        
        NSArray *courseList=indexData[@"courseList"];
        NSMutableArray *courseMArrary=[[NSMutableArray alloc] initWithCapacity:0];
        
        for (NSInteger i=0; i<[courseList count]; i++) {
            [courseMArrary addObject:@{
                                    kShopIndexCourseListID:courseList[i][@"id"]!= [NSNull null]?courseList[i][@"id"]:@" ",
                                    kShopIndexCourseListImg:courseList[i][@"img"]!= [NSNull null]?courseList[i][@"img"]:@" ",
                                    kShopIndexCourseListName:courseList[i][@"name"]!= [NSNull null]?courseList[i][@"name"]:@" ",
                                    kShopIndexCourseListPrice:courseList[i][@"price"]!= [NSNull null]?courseList[i][@"price"]:@" ",
                                    kShopIndexCourseListNum:courseList[i][@"num"]!= [NSNull null]?courseList[i][@"num"]:@" ",
                                    kShopIndexCourseListStar:courseList[i][@"star"]!= [NSNull null]?courseList[i][@"star"]:@" ",
                                    }];
        }
        return @{
                 kShopIndexShopList : indexData[@"shopList"] != [NSNull null]
                 ? indexData[@"shopList"]
                 : @"",
                 kShopIndexActImg: actImgMArray,
                 kShopIndexGoodsList : goodsMArrary,
                 kShopIndexSdtList : sdtMArrary,
                 kShopIndexCourseList : courseMArrary,
                 kShopIndexRadioList : indexData[@"radioList"] != [NSNull null]
                 ? indexData[@"radioList"]
                 : @"",
                 kShopIndexTechList : techMArrary
                 };
    }
    
    return nil;
}
@end
