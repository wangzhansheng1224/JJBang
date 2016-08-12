//
//  NSURL+OSS.m
//  jjb_user
//
//  Created by Aimee on 16/8/12.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import "NSURL+OSS.h"

@implementation NSURL (OSS)
+ (NSURL*) initWithImageURL:(NSString*)imageURL Width:(NSInteger)width{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@@%ld",
                                 ImageServer, imageURL, width * (int)Screen_Scale]];
}

//制定高，按照高度等比压缩
+ (NSURL*) initWithImageURL:(NSString*)imageURL Height:(NSInteger)height{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@@%ldh",
                                 ImageServer, imageURL, height * (int)Screen_Scale]];
}

//指定Size 返回固定大小
+ (NSURL*) initWithImageURL:(NSString*)imageURL Size:(CGSize)size{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@@1e_%dw_%dh_1c_0i_1o_90Q_1x.jpg",
                                 ImageServer, imageURL, (int)size.width * (int)Screen_Scale, (int)size.height * (int)Screen_Scale]];
}

//指定长和高 返回固定大小
+ (NSURL*) initWithImageURL:(NSString*)imageURL Width:(NSInteger)width Height:(NSInteger)height{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@@%ldw_%ldh_0e",
                                 ImageServer, imageURL, width * (int)Screen_Scale, height * (int)Screen_Scale]];
}
@end
