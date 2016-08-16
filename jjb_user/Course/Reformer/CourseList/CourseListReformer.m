//
//  CourseListReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseListReformer.h"
#import "MyCourseAPIManager.h"
#import "CourseListAPIManager.h"
#import "CourseKeys.h"

@implementation CourseListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[MyCourseAPIManager class]]||[manager isKindOfClass:[CourseListAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
  
            NSDictionary *itemData=@{
                                     kCourseID:(arrData[i][@"id"]!=[NSNull null])?arrData[i][@"id"]:@(0),
                                     kCourseName:(arrData[i][@"name"]!=[NSNull null])?arrData[i][@"name"]:@"",
                                     kCoursePrice:(arrData[i][@"price"]!=[NSNull null])?arrData[i][@"price"]:@"",
                                     kCourseNum:(arrData[i][@"registCount"]!=[NSNull null])?arrData[i][@"registCount"]:@"",
                                     kCourseStar:(arrData[i][@"star"]!=[NSNull null])?arrData[i][@"star"]:@(0),
                                     kCourseTypeName:(arrData[i][@"typeName"]!=[NSNull null])?arrData[i][@"typeName"]:@"",
                                     kCourseImg:(arrData[i][@"image"]!=[NSNull null])?arrData[i][@"image"]:@" ",
                                     kCourseLevelName:(arrData[i][@"levelName"]!=[NSNull null])?arrData[i][@"levelName"]:@""
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}
@end
