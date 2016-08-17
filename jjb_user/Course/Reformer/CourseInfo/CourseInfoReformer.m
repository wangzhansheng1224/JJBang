//
//  CourseInfoReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseInfoReformer.h"
#import "CourseDetailAPIManager.h"

NSString *const kCourseID=@"CourseID";
NSString *const kCourseName=@"CourseName";
NSString *const kCourseImg=@"CourseImg";
NSString *const kCoursePrice=@"CoursePrice";
NSString *const kCourseNum=@"CourseNum";
NSString *const kCourseStar=@"CourseStar";

NSString *const kCourseLevelName=@"CourseLevelName";
NSString *const kCourseTypeName=@"CourseTypeName";
NSString *const kCourseDescribe=@"CourseDescribe";
@implementation CourseInfoReformer

- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[CourseDetailAPIManager class]]) {
            NSDictionary *dicData=data[@"data"];
            return  @{
                      kCourseID:dicData[@"id"],
                      kCourseName:dicData[@"name"],
                      kCourseImg:dicData[@"image"],
                      kCoursePrice:dicData[@"price"],
                      kCourseNum:dicData[@"registCount"],
                      kCourseStar:dicData[@"star"],
                      kCourseDescribe:dicData[@"describe"]
                      };
    }
    return nil;
}

@end
