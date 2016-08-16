//
//  TeacherReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TeacherReformer.h"
#import "StarTeacherListAPIManager.h"


NSString * const kTeacherID = @"TeacherID";
NSString * const kTeacherPhoto = @"TeacherPhoto";
NSString * const kTeacherName = @"TeacherName";
NSString * const kTeacherStar = @"TeacherStar";

@implementation TeacherReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[StarTeacherListAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            
            NSDictionary *itemData=@{
                                     kTeacherID:(arrData[i][@"tech_id"]!=[NSNull null])?arrData[i][@"tech_id"]:@(0),
                                     kTeacherName:(arrData[i][@"tech_name"]!=[NSNull null])?arrData[i][@"tech_name"]:@" ",
                                     kTeacherPhoto:(arrData[i][@"tech_photo"]!=[NSNull null])?arrData[i][@"tech_photo"]:@" ",
                                      kTeacherStar:(arrData[i][@"tech_star"]!=[NSNull null])?arrData[i][@"tech_star"]:@(0)
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}

@end
