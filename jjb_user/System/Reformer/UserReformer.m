//
//  UserReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/5.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "UserReformer.h"
#import "UserModel.h"
#import "LoginAPIManager.h"
#import "FamilyAPIManager.h"
#import "UpdateFamilyAPIManager.h"

@implementation UserReformer

- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
       if ([manager isKindOfClass:[LoginAPIManager class]]) {
          UserModel *user=[UserModel JsonParse:data[@"data"]];
          return user;
       }
    
    return nil;
}

@end
