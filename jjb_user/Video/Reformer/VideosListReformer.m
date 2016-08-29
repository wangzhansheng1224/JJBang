//
//  VideosListReformer.m
//  jjb_user
//
//  Created by Check on 16/8/28.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "VideosListReformer.h"
#import "VideosListAPIManager.h"

NSString *const kVideosListID = @"VideosListID";
NSString *const kVideosListImageUrl = @"VideosListImageUrl";
NSString *const kVideosListToName = @"VideosListToName";
NSString *const kVideosListToPrice = @"VideosListToPrice";

@implementation VideosListReformer
- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    
    if ([manager isKindOfClass:[VideosListAPIManager class]]) {
        
        NSMutableArray *arrResult=[[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *arrData=data[@"data"];
        
        for (NSInteger i=0; i< [arrData count]; i++) {
           
            NSString *imgPath;
            NSArray *imgArr=arrData[i][@"images"];
            if (imgArr!=nil&&[imgArr count]>0) {
                imgPath=imgArr[0][@"image"];
            }
            
            NSDictionary *itemData=@{
                                     kVideosListID:arrData[i][@"id"],
                                     kVideosListToName:arrData[i][@"name"],
                                     kVideosListTocourseName:arrData[i][@"courseName"],
                                     kVideosListImageUrl:courseImg
                                     };
            [arrResult addObject:itemData];
        }
        return arrResult;
    }
    return nil;
}
@end
