//
//  CourseCatalogReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/18.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseCatalogReformer.h"
#import "CourseCatalogKeys.h"
#import "CourseCatalogAPIManager.h"

NSString *const kCourseCatalogID=@"CourseCatalogID";
NSString *const kCourseCatalogTitle=@"CourseCatalogTitle";
NSString *const kCourseCatalogDesc=@"CourseCatalogDesc";

@implementation CourseCatalogReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[CourseCatalogAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            
            NSDictionary *itemData=@{
                                     kCourseCatalogID:arrData[i][@"id"],
                                     kCourseCatalogTitle:arrData[i][@"title"],
                                     kCourseCatalogDesc:arrData[i][@"describe"]
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}


@end
