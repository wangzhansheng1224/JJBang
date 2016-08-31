//

//  jjb_user
//
//  Created by Aimee on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "StoreDetailReformer.h"
#import "StoreDetailInfoAPIManager.h"

NSString *const kStoreID;//门店ID
NSString *const kStoreName;//名称
NSString *const kStoreAddress;//地址
NSString *const kStoreMobile;//电话
NSString *const kStoreVotes;//优势
NSString *const kStoreSummary;//简介
NSString *const kStoreImage;//门店图片

@implementation StoreDetailReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    if ([manager isKindOfClass:[StoreDetailInfoAPIManager class]]) {
        
        NSDictionary * dataDict = [data objectForKey:@"data"];

        return  @{
                  kStoreID:dataDict[@"id"],
                  kStoreName:dataDict[@"name"],
                  kStoreAddress:dataDict[@"addr"],
                  kStoreMobile:dataDict[@"mobile"],
                  kStoreVotes:dataDict[@"votes"],
                  kStoreSummary:dataDict[@"notes"],
                  kStoreImage:dataDict[@"image"]
                  };
        return dataDict;
    }
    return nil;
}

@end

