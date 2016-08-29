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
NSString *const kPackagesID=@"PackagesID";
NSString *const kPackagesMembersId=@"PackagesMembersId";
NSString *const kPackagesMembersName=@"PackagesMembersName";

@implementation CoursePackagesReformer

- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[CoursePackagesAPIManager class]]) {
        
        NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
        
        NSMutableArray * packArr = [[NSMutableArray alloc] init];
        NSMutableArray * memberArr = [[NSMutableArray alloc] init];
        
        NSDictionary *dataDic = data[@"data"];
        NSArray *packagesArr = dataDic[@"packages"];
        for (int i = 0; i < packagesArr.count; i++) {
            
            NSDictionary * dic = @{
                                   kCoursePackagesID:packagesArr[i][@"courseId"],
                                   kCoursePackagesName:packagesArr[i][@"name"],
                                   kCoursePackagesNums:packagesArr[i][@"course_nums"],
                                   kCoursePackagesOrgPrice:packagesArr[i][@"org_price"],
                                   kPackagesID:packagesArr[i][@"id"]
                                   };
            [packArr addObject:dic];
        }
        [resultDic setObject:packArr forKey:@"packages"];
        
        NSArray *membersArr = dataDic[@"members"];
        for (int i = 0; i < membersArr.count; i++) {
            NSDictionary *dic = @{
                                  kPackagesMembersId:membersArr[i][@"user_id"],
                                  kPackagesMembersName:membersArr[i][@"name"]
                                  };
            [memberArr addObject:dic];
        }
        [resultDic setObject:memberArr forKey:@"members"];
        
        return resultDic;
    }
    return nil;
}

@end
