//
//  FamilyInsertReformer.m
//  jjb_user
//
//  Created by Owen on 16/9/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "FamilyInsertReformer.h"
#import "FamilyInsertKey.h"
#import "FamilyAPIManager.h"

@implementation FamilyInsertReformer

NSString * const kMyFamilyInsertMemberID=@"MyFamilyInsertMemberID";

-(id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data {
   
    if ([manager isKindOfClass:[FamilyAPIManager class]]) {
        NSMutableArray * arrResult = [NSMutableArray array];
        NSArray * arrData = data[@"data"];
        
        for (NSInteger i = 0 ; i< arrData.count; i++) {
            
            NSDictionary * dataDic = @{
                                        kMyFamilyInsertMemberID:arrData[i][@"family_id"],
                                        };
            [arrResult addObject:dataDic];
        }
        return arrResult;
    }
    return nil;
}

@end
