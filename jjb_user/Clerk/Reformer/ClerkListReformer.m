//
//  ClerkListReformer.m
//  jjb_user
//
//  Created by Aimee on 16/8/16.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "ClerkListReformer.h"
#import "ClerkListAPIManager.h"
#import "ClerkKeys.h"

NSString * const kClerkID = @"ClerkID";
NSString * const kClerkFace = @"ClerkFace";
NSString * const kClerkName = @"ClerkName";
NSString * const kClerkStar = @"ClerkStar";

@implementation ClerkListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    if ([manager isKindOfClass:[ClerkListAPIManager class]]) {
        NSMutableArray* resultMarr=[[NSMutableArray alloc] initWithCapacity:0];
        NSArray *dataArr=data[@"data"];
        for (NSDictionary *temp in dataArr) {
            
            [resultMarr addObject:@{
                                    kClerkID:temp[@"id"],
                                    kClerkName:temp[@"nickname"],
                                    kClerkFace:temp[@"useface"],
                                    kClerkStar:@(5)
                                    }];
        }
        return resultMarr;
    }
    return nil;
}

@end
