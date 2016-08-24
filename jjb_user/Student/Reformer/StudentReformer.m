//
//  StudentReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StudentReformer.h"
#import "StarStudentListAPIManger.h"

NSString * const kStudentID = @"StudentID";
NSString * const kStudentPhoto = @"StudentPhoto";
NSString * const kStudentName = @"StudentName";
NSString * const kStudentNum = @"StudentNum";
NSString * const kStudentSex = @"StudentSex";
NSString * const kStudentPhone = @"StudentPhone";
NSString * const kStudentAge = @"StudentAge";
@implementation StudentReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[StarStudentListAPIManger class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            
            NSDictionary *itemData=@{
                                     kStudentID:(arrData[i][@"sdt_id"]!=[NSNull null])?arrData[i][@"sdt_id"]:@(0),
                                     kStudentName:(arrData[i][@"sdt_name"]!=[NSNull null])?arrData[i][@"sdt_name"]:@" ",
                                     kStudentPhoto:(arrData[i][@"sdt_photo"]!=[NSNull null])?arrData[i][@"sdt_photo"]:@" ",
                                     kStudentNum:(arrData[i][@"num"]!=[NSNull null])?arrData[i][@"num"]:@(0)
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}

@end