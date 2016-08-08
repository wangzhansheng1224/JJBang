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
            NSDictionary *itemData=@{
                                     kCourseListID:arrData[i][@"id"],
                                     kCourseListName:arrData[i][@"name"],
                                     kCourseListPrice:arrData[i][@"price"],
                                     kCourseListNum:arrData[i][@"registCount"],
                                     kCourseListStar:arrData[i][@"star"],
                                     kCourseListTypeName:arrData[i][@"typeName"],
                                     kCourseListImg:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",ImageServer,arrData[i][@"image"]]],
                                     kCourseListLevel:arrData[i][@"levelName"]
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}
@end
