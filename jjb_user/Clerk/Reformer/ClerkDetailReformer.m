//
//  ClerkDetailReformer.m
//  jjb_user
//
//  Created by Owen on 16/9/8.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ClerkDetailReformer.h"
#import "ClerkDetailAPIManager.h"

@implementation ClerkDetailReformer

NSString *const kClerkDetailID=@"ClerkDetailID";
NSString *const kClerkDetailNickName=@"ClerkDetailNickName";
NSString *const kClerkDetailUserFace=@"ClerkDetailUserFace";
NSString *const kClerkDetailSex=@"ClerkDetailSex";
NSString *const kClerkDetailAge=@"ClerkDetailAge";
NSString *const kClerkDetailBrithday=@"ClerkDetailBrithday";
NSString *const kClerkDetailNotes=@"ClerkDetailNotes";
NSString *const kClerkDetailRoleName=@"kClerkDetailRoleName";

- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data {
    if ([manager isKindOfClass:[ClerkDetailAPIManager class]]) {
        NSDictionary *dic=data[@"data"];
            return @{
                                    kClerkDetailID:dic[@"user_id"]!= [NSNull null]?dic[@"user_id"]:@"",
                                    kClerkDetailNickName:dic[@"nickname"]!= [NSNull null]?dic[@"nickname"]:@"",
                                    kClerkDetailUserFace:dic[@"userface"]!= [NSNull null]?dic[@"userface"]:@"",
                                    kClerkDetailSex:dic[@"sex"]!= [NSNull null]?dic[@"sex"]:@"",
                                    kClerkDetailAge:dic[@"age"]!= [NSNull null]?dic[@"age"]:@"",
                                    kClerkDetailBrithday:dic[@"birthday"]!= [NSNull null]?dic[@"birthday"]:@"",
                                    kClerkDetailNotes:dic[@"notes"]!= [NSNull null]?dic[@"notes"]:@"",
                                    kClerkDetailRoleName:dic[@"role_name"]!= [NSNull null]?dic[@"role_name"]:@"",
                                    };
    }
    return nil;
}

@end
