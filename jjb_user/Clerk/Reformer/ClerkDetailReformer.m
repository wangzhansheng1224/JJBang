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
        NSMutableArray* resultArr=[[NSMutableArray alloc] initWithCapacity:0];
        NSArray *dataArr=data[@"data"];
        for (NSDictionary *dic in dataArr) {
            
            [resultArr addObject:@{
                                    kClerkDetailID:dic[@"user_id"],
                                    kClerkDetailNickName:dic[@"nickname"],
                                    kClerkDetailUserFace:dic[@"userface"],
                                    kClerkDetailSex:dic[@"sex"],
                                    kClerkDetailAge:dic[@"age"],
                                    kClerkDetailBrithday:dic[@"birthday"],
                                    kClerkDetailNotes:dic[@"notes"],
                                    kClerkDetailRoleName:dic[@"role_name"],
                                    }];
        }
        return resultArr;
    }
    return nil;
}

@end
