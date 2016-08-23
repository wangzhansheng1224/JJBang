//
//  CoursePackagesReformer.m
//  jjb_user
//
//  Created by Check on 16/8/22.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CoursePackagesReformer.h"
#import "CoursePackagesAPIManager.h"

NSString *const kCoursePackagesNums=@"CoursePackagesNums";
NSString *const kCoursePackagesID=@"CoursePackagesID";
NSString *const kCoursePackagesName=@"CoursePackagesName";
NSString *const kCoursePackagesOrgPrice=@"CoursePackagesOrgPrice";

@implementation CoursePackagesReformer

- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[CoursePackagesAPIManager class]]) {
        
        NSMutableArray *resultArr = [[NSMutableArray alloc] init];
        NSArray *dataArr = data[@"data"];
        
        for (int i = 0; i < dataArr.count; i++) {
            
            NSDictionary * dic = @{
                      kCoursePackagesID:dataArr[i][@"courseId"],
                      kCoursePackagesName:dataArr[i][@"name"],
                      kCoursePackagesNums:dataArr[i][@"course_nums"],
                      kCoursePackagesOrgPrice:dataArr[i][@"org_price"]
                      };
            
            [resultArr addObject:dic];
        }
        
        return resultArr;
    }
    return nil;
}

@end
