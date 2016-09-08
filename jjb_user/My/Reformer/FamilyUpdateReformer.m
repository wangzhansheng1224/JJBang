//
//  FamilyUpdateReformer.m
//  jjb_user
//
//  Created by Owen on 16/9/7.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "FamilyUpdateReformer.h"
#import "UpdateFamilyAPIManager.h"
#import "FamilyUpdateKey.h"

@implementation FamilyUpdateReformer

NSString * const kMyFamilyUpdateMemberID=@"MyFamilyUpdateMemberID";

-(id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    if ([manager isKindOfClass:[UpdateFamilyAPIManager class]]) {
        NSMutableArray * arrResult = [NSMutableArray array];
        NSArray * arrData = data[@"data"];
        
        for (NSInteger i = 0 ; i< arrData.count; i++) {
            
            NSDictionary * dataDic = @{
                                       kMyFamilyUpdateMemberID:arrData[i][@"family_id"],
                                       };
            [arrResult addObject:dataDic];
        }
        return arrResult;
    }
    return nil;
}
@end
