//
//  CourseListReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseListReformer.h"
#import "MyCourseAPIManager.h"

NSString *const kCourseListID=@"CourseListID";
NSString *const kCourseListName=@"CourseListName";
NSString *const kCourseListImg=@"CourseListImg";
NSString *const kCourseListPrice=@"CourseListPrice";
NSString *const kCourseListNum=@"CourseListNum";
NSString *const kCourseListStar=@"CourseListStar";
NSString *const kCourseListLevel=@"CourseListLevel";
NSString *const kCourseListTypeName=@"CourseListTypeName";
@implementation CourseListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[MyCourseAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            NSURL *url= [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",ImageServer,(arrData[i][@"image"]!=[NSNull null])?arrData[i][@"image"]:@""]];
            if (url==nil) {
                url=[[NSURL alloc] initFileURLWithPath:@"img_default"];
            }
            
            NSDictionary *itemData=@{
                                     kCourseListID:(arrData[i][@"id"]!=[NSNull null])?arrData[i][@"id"]:@(0),
                                     kCourseListName:(arrData[i][@"name"]!=[NSNull null])?arrData[i][@"name"]:@"",
                                     kCourseListPrice:(arrData[i][@"price"]!=[NSNull null])?arrData[i][@"price"]:@"",
                                     kCourseListNum:(arrData[i][@"registCount"]!=[NSNull null])?arrData[i][@"registCount"]:@"",
                                     kCourseListStar:(arrData[i][@"star"]!=[NSNull null])?arrData[i][@"star"]:@(0),
                                     kCourseListTypeName:(arrData[i][@"typeName"]!=[NSNull null])?arrData[i][@"typeName"]:@"",
                                     kCourseListImg:url,
                                     kCourseListLevel:(arrData[i][@"levelName"]!=[NSNull null])?arrData[i][@"levelName"]:@""
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}
@end
