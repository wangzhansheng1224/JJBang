//
//  CourseRegisterListReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/25.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "CourseRegisterListReformer.h"
#import "CourseRegisterListAPIManager.h"
#import "UserKeys.h"

NSString *const kUserID=@"UserID";
NSString *const kUserName=@"UserName";
NSString *const kUserFace=@"UserFace";

@implementation CourseRegisterListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[CourseRegisterListAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            
            NSDictionary *dataDic=arrData[i];
            NSDictionary *itemData=@{
                                     kUserID:dataDic[@"id"],
                                     kUserName:dataDic[@"nickname"],
                                     kUserFace:dataDic[@"userface"]
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}

@end
