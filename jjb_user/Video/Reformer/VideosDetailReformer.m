//
//  VideosDetailReformer.m
//  jjb_user
//
//  Created by Check on 16/8/28.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "VideosDetailReformer.h"
#import "VideosDetailAPIManager.h"

NSString *const kVideosDetailID=@"VideosDetailID";
NSString *const kVideosDetailName=@"VideosDetailName";
NSString *const kkVideosUrlString=@"VideosUrlString";

@implementation VideosDetailReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    
    if ([manager isKindOfClass:[VideosDetailAPIManager class]]) {
        NSDictionary *dataDic=data[@"data"];
        return  @{
                                     kVideosDetailID:dataDic[@"id"],
//                                     kVideosDetailName:dataDic[@"name"],
//                                     kkVideosUrlString:dataDic[@"code"]
                                     };

    }
    return nil;
}
@end