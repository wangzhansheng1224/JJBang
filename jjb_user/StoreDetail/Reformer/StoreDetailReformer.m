//

//  jjb_user
//
//  Created by Aimee on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StoreDetailReformer.h"

//NSString * const kTeacherID = @"TeacherID";
//NSString * const kTeacherPhoto = @"TeacherPhoto";
//NSString * const kTeacherName = @"TeacherName";

@implementation StoreDetailReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
//    
//    if ([manager isKindOfClass:[TeacherDetailAPIManager class]]) {
//        
//        NSDictionary *dataDic=[data objectForKey:@"data"];
//        return @{
//                 kTeacherID:dataDic[@"user_id"],
//                 kTeacherName:dataDic[@"nickname"],
//                 kTeacherPhoto:dataDic[@"userface"],
//                 kTeacherStar:@(5),
//                 kTeacherSex:dataDic[@"sex"],
//                 kTeacherNotes:dataDic[@"phone"],
//                 kTeacherNotes:dataDic[@"notes"],
//                 kTeacherSummary:dataDic[@"notes1"],
//                 kTeacherWorkYears:dataDic[@"work_years"],
//                 kTeacherPhone:dataDic[@"phone"],
//                 kTeacherAddress:dataDic[@"address"]
//                 };
//        
//    }
//    if ([manager isKindOfClass:[TeacherListAPIManager class]]) {
//        
//        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
//        
//        NSArray *arrData=data[@"data"];
//        for (NSDictionary *dic in arrData) {
//            [arrResult addObject:@{
//                                   kTeacherID:dic[@"user_id"],
//                                   kTeacherName:dic[@"nickname"],
//                                   kTeacherPhoto:dic[@"userface"],
//                                   kTeacherStar:@(5)
//                                   }];
//        }
//        return arrResult;
//    }
    return nil;
}

@end
