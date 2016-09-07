//
//  TeacherReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "TeacherReformer.h"
#import "StarTeacherListAPIManager.h"
#import "TeacherListAPIManager.h"
#import "TeacherDetailAPIManager.h"


NSString * const kTeacherID = @"TeacherID";
NSString * const kTeacherPhoto = @"TeacherPhoto";
NSString * const kTeacherName = @"TeacherName";
NSString * const kTeacherStar = @"TeacherStar";
NSString * const kTeacherSex = @"TeacherSex";
NSString * const kTeacherNotes = @"TeacherNotes";
NSString * const kTeacherSummary = @"TeacherSummary";
NSString * const kTeacherWorkYears = @"TeacherWorkYears";
NSString * const kTeacherAddress = @"TeacherAddress";
NSString * const kTeacherPhone = @"TeacherPhone";

@implementation TeacherReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    
    if ([manager isKindOfClass:[TeacherDetailAPIManager class]]) {
        
        NSDictionary *dataDic=[data objectForKey:@"data"];
        JJBLog(@"!!!!!!!%@",dataDic);
        return @{
                 kTeacherID:dataDic[@"user_id"],
                 kTeacherName:dataDic[@"nickname"],
                 kTeacherPhoto:dataDic[@"userface"],
                 kTeacherStar:@(5),
                 kTeacherSex:dataDic[@"sex"],
//                 kTeacherPhone:dataDic[@"phone"],
                 kTeacherNotes:dataDic[@"notes1"],
                 kTeacherSummary:dataDic[@"notes"],
                 kTeacherWorkYears:dataDic[@"work_years"],
                 kTeacherPhone:dataDic[@"phone"],
                 kTeacherAddress:dataDic[@"address"]
                 };
        
    }
    if ([manager isKindOfClass:[StarTeacherListAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            
            NSDictionary *itemData=@{
                                     kTeacherID:(arrData[i][@"tech_id"]!=[NSNull null])?arrData[i][@"tech_id"]:@(0),
                                     kTeacherName:(arrData[i][@"tech_name"]!=[NSNull null])?arrData[i][@"tech_name"]:@" ",
                                     kTeacherPhoto:(arrData[i][@"tech_photo"]!=[NSNull null])?arrData[i][@"tech_photo"]:@" ",
                                      kTeacherStar:(arrData[i][@"tech_star"]!=[NSNull null])?arrData[i][@"tech_star"]:@(0)
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    
    if ([manager isKindOfClass:[TeacherListAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        for (NSDictionary *dic in arrData) {
            [arrResult addObject:@{
                                   kTeacherID:dic[@"user_id"],
                                   kTeacherName:dic[@"nickname"],
                                   kTeacherPhoto:dic[@"userface"],
                                   kTeacherStar:@(5)
                                   }];
        }
        return arrResult;
    }
    return nil;
}

@end
