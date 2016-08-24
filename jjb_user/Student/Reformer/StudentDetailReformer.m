//
//  StudentDetailReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/24.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StudentDetailReformer.h"
#import "StudentKeys.h"
#import "StudentDetailAPIManager.h"

@implementation StudentDetailReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[StudentDetailAPIManager class]]) {
        
        NSDictionary *dataDic=[data objectForKey:@"data"];
        return @{
            kStudentID:dataDic[@"user_id"],
            kStudentName:dataDic[@"nickname"],
            kStudentPhoto:dataDic[@"userface"],
            kStudentSex:dataDic[@"sex"],
            kStudentPhone:dataDic[@"phone"]
        };
    }
    return nil;
}

@end
