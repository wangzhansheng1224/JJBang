//
//  NSURL+OSS.h
//  jjb_user
//
//  Created by Aimee on 16/8/12.
//  Copyright © 2016年 北京家家帮科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (OSS)
//指定长，按照长度等比压缩
+ (NSURL*) initWithImageURL:(NSString*)imageURL Width:(NSInteger)width;
//制定高，按照高度等比压缩
+ (NSURL*) initWithImageURL:(NSString*)imageURL Height:(NSInteger)height;
//指定Size 返回固定大小
+ (NSURL*) initWithImageURL:(NSString*)imageURL Size:(CGSize)size;
//指定长和高 返回固定大小
+ (NSURL*) initWithImageURL:(NSString*)imageURL Width:(NSInteger)width Height:(NSInteger)height;
@end
