//
//  ActivityRegisterListReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/2.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ActivityRegisterListReformer.h"
#import "ActivityRegisterListAPIManager.h"

NSString *const kActivityRegisterListUserID=@"ActivityRegisterListUserID";
NSString *const kActivityRegisterListNickName=@"ActivityRegisterListNickName";
NSString *const kActivityRegisterListUserFace=@"ActivityRegisterListUserFace";
NSString *const kActivityRegisterListSex=@"ActivityRegisterListSex";
NSString *const kActivityRegisterListRemark=@"ActivityRegisterListRemark";
NSString *const kActivityRegisterListMedal=@"ActivityRegisterListMedal";

@implementation ActivityRegisterListReformer

- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[ActivityRegisterListAPIManager class]]) {
            
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
            
            NSDictionary *itemData=@{
                                     kActivityRegisterListUserID:(arrData[i][@"user_id"]!=[NSNull null])?arrData[i][@"user_id"]:0,
                                     kActivityRegisterListNickName:(arrData[i][@"nickname"]!=[NSNull null])?arrData[i][@"nickname"]:@" ",
                                     kActivityRegisterListUserFace:(arrData[i][@"userface"]!=[NSNull null])?arrData[i][@"userface"]:@" ",
                                     kActivityRegisterListSex:(arrData[i][@"sex"]!=[NSNull null])?arrData[i][@"sex"]:@"0",
                                     kActivityRegisterListRemark:(arrData[i][@"remark"]!=[NSNull null])?arrData[i][@"remark"]:@" ",
                                     kActivityRegisterListMedal:(arrData[i][@"medal"]!=[NSNull null])?arrData[i][@"medal"]:@"0"
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
        }
    return nil;
}

@end
