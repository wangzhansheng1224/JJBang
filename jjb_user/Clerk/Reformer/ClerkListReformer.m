//
//  ClerkListReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ClerkListReformer.h"
#import "ClerkListAPIManager.h"
#import "ClerkDetailAPIManager.h"

NSString * const kClerkID = @"ClerkID";
NSString * const kClerkFace = @"ClerkFace";
NSString * const kClerkName = @"ClerkName";
NSString * const kClerkStar = @"ClerkStar";
/**
 *  性别
 */
NSString *const kClerkGender = @"ClerkGender";
/**
 *  勋章
 */
NSString *const kClerkMedal = @"ClerkMedal";
/**
 *  年龄
 */
 NSString *const kClerkAge = @"ClerkAge";
/**
 *  生日
 */

 NSString *const kClerkBirthday = @"ClerkBirthday";
/**
 *  角色名称
 */
NSString *const kClerkRoleName = @"ClerkRoleName";




@implementation ClerkListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[ClerkListAPIManager class]]) {
        NSMutableArray* resultMarr=[[NSMutableArray alloc] initWithCapacity:0];
        NSArray *dataArr=data[@"data"];
        for (NSDictionary *temp in dataArr) {
            
            [resultMarr addObject:@{
                                    kClerkID:temp[@"id"],
                                    kClerkName:temp[@"nickname"],
                                    kClerkFace:temp[@"userface"],
                                    kClerkStar:@(5),
                                    kClerkGender:temp[@"sex"],
                                    kClerkMedal:temp[@"medal"],
                                    kClerkAge:temp[@"age"],
                                    kClerkBirthday:temp[@"birthday"],
                                    kClerkRoleName:temp[@"role_name"]
                                    }];
        }
        return resultMarr;
    }
    return nil;
}

@end
