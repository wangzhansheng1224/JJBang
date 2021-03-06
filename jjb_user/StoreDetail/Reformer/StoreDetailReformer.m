//

//  jjb_user
//
//  Created by Aimee on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StoreDetailReformer.h"
#import "StoreDetailInfoAPIManager.h"

NSString * const kStoreID = @"StoreID";
NSString * const kStoreName = @"StoreName";
NSString * const kStoreAddress = @"StoreAddress";
NSString * const kStoreMobile = @"StoreMobile";
NSString * const kStoreVotes = @"StoreVotes";
NSString * const kStoreSummary = @"StoreSummary";
NSString * const kStoreImage = @"StoreImage";

@implementation StoreDetailReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    
    if ([manager isKindOfClass:[StoreDetailInfoAPIManager class]]) {
        
        NSDictionary *dataDic=[data objectForKey:@"data"];
        return @{
                 kStoreID:dataDic[@"id"],
                 kStoreName:dataDic[@"name"],
                 kStoreAddress:dataDic[@"addr"],
                 kStoreMobile:dataDic[@"mobile"],
                 kStoreVotes:dataDic[@"votes"],
                 kStoreSummary:dataDic[@"notes"],
                 kStoreImage:dataDic[@"image"],
                 };
        
    }
    return nil;
}

@end

